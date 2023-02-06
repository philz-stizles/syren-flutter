import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syren/models/firebase_model.dart';

class BloodSugarModel extends FirebaseModel {
  late int fasting;
  late int random;
  late Timestamp timeStamp;

  BloodSugarModel({
    String? id,
    required this.fasting,
    required this.random,
    required this.timeStamp,
  }) : super(id);

  String get fastingDisplay => '${fasting}mg/dL';
  String get randomDisplay => '${random}mg/dL';
  String get bp => '$fasting/${random}mg/dL';
  String formatedTimeStamp(String format) =>
      DateFormat(format).format(timeStamp.toDate());

  BloodSugarModel.fromJson(Map<String, dynamic> json) : super(json['id']) {
    fasting = json['fasting'];
    random = json['random'];
    timeStamp = json['timeStamp'];
  }

  BloodSugarModel.fromDocumentSnapshot(DocumentSnapshot doc) : super(doc.id) {
    fasting = doc['fasting'];
    random = doc['random'];
    timeStamp = doc['timeStamp'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fasting': fasting,
      'random': random,
      'timeStamp': timeStamp
    };
  }

  @override
  String toString() => 'BloodSugarModel<$id>';
}
