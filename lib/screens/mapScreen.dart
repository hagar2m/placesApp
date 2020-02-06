import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelectiong;
  MapScreen(
    {
      this.initialLocation = const PlaceLocation(latitude: 30.143525, longitude: 31.00149),
      this.isSelectiong = false // defult value
    });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Map'),
          actions: <Widget>[
            widget.isSelectiong ?
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => _pickedLocation == null ? 
              null : Navigator.of(context).pop(_pickedLocation),
            )
            :
            SizedBox()
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude),
            zoom: 10
          ),
          onTap: widget.isSelectiong ?  _selectLocation : null,
          markers:( _pickedLocation == null && widget.isSelectiong) ? null : {
            Marker(
              markerId: MarkerId('m1'),
              position: _pickedLocation ?? LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude)
            )

          } ,
        ));
  }
}
