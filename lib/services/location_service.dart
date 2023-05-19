import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$googleMapsApiKey';
  }

  static Future<String> getPlaceAddress(
      {double? latitude, double? longitude}) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleMapsApiKey');
    final response = await http.get(url);
    if (kDebugMode) {
      print(response.body);
    }
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
