import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BloodPressureModel {
  String? id;
  late int systolic;
  late int diastolic;
  late Timestamp timeStamp;

  BloodPressureModel(
      {this.id,
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['systolic'] = systolic;
    data['diastolic'] = diastolic;
    data['timeStamp'] = timeStamp;

    return data;
  }

  @override
  String toString() => 'BloodPressureModel<$id>';
}
