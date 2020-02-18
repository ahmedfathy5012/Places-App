import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/places_list_screen.dart';
import './providers/great_places.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(

          primarySwatch: Colors.blue,
          accentColor : Colors.amber,
        ),
        home: PlacesListScreen(),
      ),
    );
  }
}


