import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/greatPlaces.dart';
import 'screens/placesListScreen.dart';
import 'screens/addPlaceScreen.dart';
import 'screens/placeDetailsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
          title: 'Places Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: PlacesListScreen(),
          routes: {
            AddPlaceScreen.routeName: (_) => AddPlaceScreen(),
            PlaceDetailScreen.routeName: (_) => PlaceDetailScreen()
          },
        ),
          
    );
  }
}
