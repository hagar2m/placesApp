import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
// import '../helpers/location_helper.dart';


class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items]; // return a copy of items
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String title, File pickedImage, PlaceLocation pickedLocation) async{
    // get address from location //
    // final address = await Locationhelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);

    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: 'address'
    );

    final newPlace = Place(
        id: DateTime.now().toString(),
        name: title,
        image: pickedImage,
        location: updatedLocation
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert({
      "$idField": newPlace.id,
      "$titleField": newPlace.name,
      "$imageField": newPlace.image.path,
      "$locLatField": newPlace.location.latitude,
      "$locLongField": newPlace.location.longitude,
      "$addressField": newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData();
    _items = dataList
        .map((Map item) => Place(
            id: item['$idField'],
            name: item['$titleField'],
            image: File(item['$imageField']),
            location: PlaceLocation(
              latitude: item['$locLatField'],
              longitude: item['$locLongField'],
              address: item['$addressField'],
            )
          ))
        .toList();
    notifyListeners();
  }
}
