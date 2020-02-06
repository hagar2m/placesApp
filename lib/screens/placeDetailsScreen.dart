import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/greatPlaces.dart';
import '../screens/mapScreen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/placeDetailScreen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.name),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(selectedPlace.image,
            fit: BoxFit.cover
            ),
          ),
          SizedBox(height: 10,),
          Text(selectedPlace.location.address,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
          ),
          SizedBox(height: 10),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => MapScreen(
                  initialLocation: selectedPlace.location, 
                  isSelectiong: false,
                )
              )
            ),
          )
        ],
      )
    );
  }
}