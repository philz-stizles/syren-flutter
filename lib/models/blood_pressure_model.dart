import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syren/models/models.dart';

class BloodPressureModel implements FirebaseModel {
  @override
  String? id;
  late int systolic;
  late int diastolic;
  late Timestamp timeStamp;

  BloodPressureModel(
      {String? id,
      required this.systolic,
      required this.diastolic,
      required this.timeStamp});

  String get systolicDisplay => '${systolic}mmHg';
  String get diastolicDisplay => '${diastolic}mmHg';
  String get bp => '$systolic/${diastolic}mmHg';
  String formatedTimeStamp(String format) =>
      DateFormat(format).format(timeStamp.toDate());

  BloodPressureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systolic = json['systolic'];
    diastolic = json['diastolic'];
    timeStamp = json['timeStamp'];
  }

  BloodPressureModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    systolic = doc['systolic'];
    diastolic = doc['diastolic'];
    timeStamp = doc['timeStamp'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'systolic': systolic,
      'diastolic': diastolic,
      'timeStamp': timeStamp,
    };
  }

  @override
  String toString() => 'BloodPressureModel<$id>';
}
