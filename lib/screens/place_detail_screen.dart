import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import 'map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250.0,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Address',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapScreen(
                        intialLocation: selectedPlace.location,
                        isSelecting: false,
                      )));
            },
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
