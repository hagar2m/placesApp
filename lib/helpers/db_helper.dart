import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

const tableName = 'userPlaces';
const idField = 'id';
const titleField = 'name';
const imageField = 'image';
const addressField = 'address';
const locLatField = 'latitude';
const locLongField = 'longitude';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName($idField TEXT PRIMARY KEY, $titleField TEXT, $imageField TEXT, $addressField TEXT, $locLatField REAL, $locLongField REAL)'); // create new file (places.db) in this path
      },
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm
            .replace // to make ovveride if you insert data with the same id
        );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    return db.query(tableName); // get all data from table
  }
}
