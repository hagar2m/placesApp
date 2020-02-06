
import 'dart:io';

import 'package:flutter/foundation.dart';

class Place {
  final String id;
  final String name;
  final PlaceLocation location;
  final File image;

  Place({ 
    @required this.id, 
    @required this.name, 
    @required this.location, 
    @required this.image 
  });

}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({ 
    @required this.latitude,
     @required this.longitude, 
     this.address 
  });
}