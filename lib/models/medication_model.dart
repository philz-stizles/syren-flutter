import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syren/models/models.dart';

class MedicationModel implements FirebaseModel {
  @override
  String? id;
  String? imageLocation;
  String? title;
  String? pills;
  String? time;
  String? when;
  String? daysLeft;
  String? prescribedBy;
  late MedicationSource medicationSource;

  MedicationModel(
      {this.id,
      this.imageLocation,
      this.title,
      this.pills,
      this.time,
      this.when,
      this.daysLeft,
      this.prescribedBy,
      this.medicationSource = MedicationSource.prescribed});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    pills = json['pills'];
    time = json['time'];
    when = json['when'];
    daysLeft = json['daysLeft'];
  }

  MedicationModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    imageLocation = doc['imageLocation'];
    title = doc['title'];
    pills = doc['pills'];
    time = doc['time'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageLocation'] = imageLocation;
    data['title'] = title;
    data['pills'] = pills;
    data['time'] = time;
    data['when'] = when;
    data['daysLeft'] = daysLeft;
    data['prescribedBy'] = prescribedBy;
    data['medicationSource'] = medicationSource;

    return data;
  }
}

enum MedicationSource { prescribed, random }
