import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceLocationModel {
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocationModel(
      {required this.latitude, required this.longitude, this.address});

  // PlaceLocationModel.fromJson(Map<String, dynamic> json) {
  //   latitude = json['latitude'];
  //   longitude = json['longitude'];
  //   address = json['address'];
  // }

  // PlaceLocationModel.fromDocumentSnapshot(DocumentSnapshot doc) {
  //   latitude = doc['latitude'];
  //   longitude = doc['longitude'];
  //   address = doc['address'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['latitude'] = latitude;
  //   data['longitude'] = longitude;
  //   data['address'] = address;

  //   return data;
  // }
}

class PlaceModel {
  late String id;
  late String title;
  late PlaceLocationModel location;
  File? image;

  PlaceModel({required this.id, required this.title, required this.location});

  PlaceModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  PlaceModel.fromDocumentSnapshot(DocumentSnapshot doc, this.id) {
    title = doc['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;

    return data;
  }
}
