import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:syren/widgets/widgets.dart';

class GeolocatorService {
  Rxn<String> _currentAddress = Rxn<String>();
  Rxn<Position> _currentPosition = Rxn<Position>();

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      UIConfig.showSnackBar(
          message: 'Location services are disabled. Please enable the services',
          backgroundColor: Colors.white);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        UIConfig.showSnackBar(
            message: 'Location permissions are denied',
            backgroundColor: Colors.white);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      UIConfig.showSnackBar(
          message:
              'Location permissions are permanently denied, we cannot request permissions.',
          backgroundColor: Colors.white);
      return false;
    }
    return true;
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentPosition.value = position;
      return position;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Future<void> getAddressFromLatLng(Position position) async {
  Future<String> getAddressFromLatLng(Position position) async {
    return await placemarkFromCoordinates(
            _currentPosition.value!.latitude, _currentPosition.value!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      var address =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      _currentAddress.value = address;
      return address;
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
