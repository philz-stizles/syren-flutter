import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/places.dart';

class LocationController extends GetxController {
  final Placemark _pickPlaceMark = Placemark();

  get pickPlaceMark => _pickPlaceMark;

  List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(
      BuildContext context, String? search) async {
    if (search != null && search.isNotEmpty) {
      http.Response response = await http.get(Uri(host: ''));
      var data = jsonDecode(response.body.toString());
      if (kDebugMode) {
        print(data);
      }
      if (data['status'] == 'OK') {
        _predictionList = [];
        _predictionList = data.map();
      } else {}
    }

    return _predictionList;
  }
}
