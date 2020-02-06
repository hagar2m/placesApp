import 'dart:convert';

import 'package:http/http.dart' as http;

const GoggleApiKey = 'AIzaSyANnjWOIMXlIr-B3Sv6qWmcAW4sjDaxEnA';

class Locationhelper {
  static String generateLocationPreviewImage({ double lat, double long }) {
    String url = 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$long&key=$GoggleApiKey';
    print(url);
    return url;
  }

  static Future<String> getPlaceAddress(double lat, double laong) async {
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$laong&key=$GoggleApiKey';
    final res = await http.get(url);
// return json.decode(response.body)['results'][0]['formatted_address'];
    var body = res.body;
    print("body: $body");

    return json.decode(res.body)['results'][0]['formatted_address'];
  }
}