import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function  onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  double longi =  -122.084 ;
  double lati = 20.02;


  Future<void> _showPreview(double lat , double lng){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      longi = lng;
      lati = lat ;
    });
  }

  Future<void> _getCurrentUserLocation() async {

    try{
      final locData = await Location().getLocation();
      print(locData.longitude);
      print(locData.latitude);
      _showPreview(locData.latitude,locData.longitude);
      widget.onSelectPlace(locData.latitude,locData.longitude);
    }catch(error){
      return;
    }

  }

  Future _selectOnMap() async {
    final  selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
              isSelecting: true,
            )));
    if (selectedLocation == null) {
      return;
    }
    widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude);
    _showPreview(selectedLocation.latitude,selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170.0,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
                  'No location choosen',
                  textAlign: TextAlign.center,
                )
              :
        //  Image.network(
          //          _previewImageUrl,
          //      fit: BoxFit.cover,
      //      width: double.infinity,
          //        ),
          GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(lati, longi),zoom: 16)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
