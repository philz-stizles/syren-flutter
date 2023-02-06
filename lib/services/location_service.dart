import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

var googleApiKey = dotenv.get('MAP_API_KEY');

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getPlaceAddress(
      {double? latitude, double? longitude}) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleApiKey');
    final response = await http.get(url);
    if (kDebugMode) {
      print(response.body);
    }
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
