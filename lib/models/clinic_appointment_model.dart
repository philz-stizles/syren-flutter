import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syren/models/models.dart';

class ClinicAppointmentModel implements FirebaseModel {
  @override
  String? id;
  String? address;
  String? specialty;
  String? note;
  late DateTime date;
  late String time;

  ClinicAppointmentModel({
    this.id,
    this.address,
    this.specialty,
    this.note,
    required this.date,
    required this.time,
  });

  ClinicAppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    specialty = json['specialty'];
    note = json['note'];
    date = json['date'];
    time = json['time'];
  }

  ClinicAppointmentModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    address = doc['address'];
    specialty = doc['specialty'];
    note = doc['note'];
    date = doc['date'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['specialty'] = specialty;
    data['note'] = note;
    data['time'] = time;
    data['time'] = time;

    return data;
  }
}
