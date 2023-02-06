import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syren/models/models.dart';

class HomeVisitModel implements FirebaseModel {
  @override
  String? id;
  String? address;
  String? specialty;
  String? samples;
  late DateTime date;
  late String time;

  HomeVisitModel({
    this.id,
    this.address,
    this.specialty,
    this.samples,
    required this.date,
    required this.time,
  });

  HomeVisitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    specialty = json['specialty'];
    samples = json['samples'];
    date = json['date'];
    time = json['time'];
  }

  HomeVisitModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    address = doc['address'];
    specialty = doc['specialty'];
    samples = doc['samples'];
    date = doc['date'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['specialty'] = specialty;
    data['samples'] = samples;
    data['time'] = time;
    data['date'] = date;

    return data;
  }
}
