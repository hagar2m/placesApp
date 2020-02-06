import 'package:flutter/material.dart';
import 'package:places_app/screens/placeDetailsScreen.dart';
import 'package:provider/provider.dart';

import 'addPlaceScreen.dart';
import '../providers/greatPlaces.dart';
import '../models/place.dart';
import '../screens/placeDetailsScreen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) 
          return Center(
            child: CircularProgressIndicator()
          );

          return Consumer<GreatPlaces>(
            child: Center(
              child: Text('Got no places yet, start adding some!'),
            ),
            builder: (context, greatPlaces, ch) => greatPlaces.items.length <= 0
                ? ch
                : ListView.builder(
                    itemCount: greatPlaces.items.length,
                    itemBuilder: (ctx, i) =>
                        _buildPlaceItem(greatPlaces.items[i], context),
                )
          );
        },
      ),
    );
  }

  _buildPlaceItem(Place item, BuildContext context ) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(
        PlaceDetailScreen.routeName,
        arguments: item.id
      ),
      title: Text(item.name),
      subtitle: Text(item.location.address),
      leading: CircleAvatar(
        backgroundImage: FileImage(item.image),
      ),
    );
  }
}
