import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../screens/mapScreen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // String _previewImageUrl;
  Future<void> _getCurrentLocation() async{
    print('_getCurrentLocation');
    final locData = await Location().getLocation();
     print('latitude: ${locData.latitude}');
    print('long: ${locData.longitude}');
    // final staicMapImageUrl = Locationhelper.generateLocationPreviewImage(lat: locData.latitude, long: locData.longitude);
   
    // print('staicMapImageUrl: $staicMapImageUrl');

    // setState(() {
    //   _previewImageUrl = staicMapImageUrl;
    // });
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  _onSelectMap() async{
    final LatLng _selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(isSelectiong: true)
      ));
    if (_selectedLocation ==  null) {
      return;
    }
    /////////
  
    widget.onSelectPlace(_selectedLocation.latitude, _selectedLocation.longitude);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Container(
        //   width: double.infinity,
        //   height: 170,
        //   decoration: BoxDecoration(border: Border.all(
        //     width: 1,
        //     color: Colors.grey
        //   )),
        //   child: _previewImageUrl == null ?
        //   Text('No location chosen', textAlign: TextAlign.center) 
        //   :
        //   Image.network(_previewImageUrl, 
        //   fit: BoxFit.cover,
        //   width: double.infinity,
        //   ),
        // ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation,
            ),
            
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () => _onSelectMap()
            )

          ],
        )
      ],
    );
  }
}