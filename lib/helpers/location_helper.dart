import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyCKFaHnphHIH8OzzXwlT-ssGUi4utz-qVk';
//const GOOGLE_API_KEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI';
class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
//  static Future<String> getPlaceAddress(double lat, double lng) async {
//    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
//    final response = await http.get(url);
//    return json.decode(response.body)['results'][0]['formatted_address'];
//  }

  static Future<String> getAddress(double lat , double lng) async {
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(lat,lng);
    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      return pos.thoroughfare + ', ' + pos.locality;
    }
    return "";
  }
}