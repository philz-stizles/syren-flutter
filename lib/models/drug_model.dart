import 'package:cloud_firestore/cloud_firestore.dart';

class DrugModel {
  String? id;
  String? imageLocation;
  String? title;
  String? pills;
  String? time;
  String? when;
  String? daysLeft;
  bool? hasAllergies;
  String? allergies;
  String? medications;

  DrugModel({
    this.id,
    this.imageLocation,
    this.title,
    this.pills,
    this.time,
    this.when,
    this.daysLeft,
    this.hasAllergies,
    this.allergies,
    this.medications,
  });

  DrugModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    pills = json['pills'];
    time = json['time'];
    when = json['when'];
    daysLeft = json['daysLeft'];
    hasAllergies = json['hasAllergies'];
    allergies = json['allergies'];
  }

  DrugModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    imageLocation = doc['imageLocation'];
    title = doc['title'];
    pills = doc['pills'];
    time = doc['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageLocation'] = imageLocation;
    data['title'] = title;
    data['pills'] = pills;
    data['time'] = time;
    data['when'] = when;
    data['daysLeft'] = daysLeft;
    data['hasAllergies'] = hasAllergies;
    data['allergies'] = allergies;
    data['medications'] = medications;

    return data;
  }
}
