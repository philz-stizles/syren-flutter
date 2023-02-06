import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:syren/models/models.dart';

class PlacesService {
  final baseUrl = dotenv.get('MAP_PLACES_BASE_URL');
  final key = dotenv.get('MAP_API_KEY');

  Future<List<PlaceSearchModel>> getAutocomplete(String search) async {
    var url =
        '$baseUrl/autocomplete/json?input=$search&types=(cities)&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    if (kDebugMode) {
      print(json);
    }
    var jsonResults = json['predictions'] as List;
    return jsonResults
        .map((place) => PlaceSearchModel.fromJson(place))
        .toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url = '$baseUrl/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    if (kDebugMode) {
      print(jsonResult);
    }
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(
      double lat, double lng, String placeType) async {
    var url =
        '$baseUrl/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
