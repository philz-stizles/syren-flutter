import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BloodSugarModel {
  String? id;
  late int fasting;
  late int random;
  late Timestamp timeStamp;

  BloodSugarModel({
    this.id,
    required this.fasting,
    required this.random,
    required this.timeStamp,
  });

  String get fastingDisplay => '${fasting}mg/dL';
  String get randomDisplay => '${random}mg/dL';
  String get bp => '$fasting/${random}mg/dL';
  String formatedTimeStamp(String format) =>
      DateFormat(format).format(timeStamp.toDate());

  BloodSugarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fasting = json['fasting'];
    random = json['random'];
    timeStamp = json['timeStamp'];
  }

  BloodSugarModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    fasting = doc['fasting'];
    random = doc['random'];
    timeStamp = doc['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fasting'] = fasting;
    data['random'] = random;
    data['timeStamp'] = timeStamp;

    return data;
  }

  @override
  String toString() => 'BloodSugarModel<$id>';
}
