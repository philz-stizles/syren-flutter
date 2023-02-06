import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syren/models/models.dart';

class OTPModel extends FirebaseModel {
  String? userId;
  String? email;
  String? code;
  DateTime? expiresAt;
  late Timestamp timeStamp;

  OTPModel(
      {String? id,
      this.userId,
      this.email,
      required this.code,
      required this.expiresAt,
      required this.timeStamp})
      : super(id);

  OTPModel.fromJson(Map<String, dynamic> json) : super(json['id']) {
    code = json['code'];
    email = json['email'];
    expiresAt = (json['expiresAt'] as Timestamp).toDate();
    timeStamp = json['timeStamp'];
  }

  OTPModel.fromDocumentSnapshot(DocumentSnapshot doc) : super(doc.id) {
    code = doc['code'];
    email = doc['email'];
    expiresAt = doc['expiresAt'];
    timeStamp = doc['timeStamp'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'email': email,
      'expiresAt': expiresAt,
      'timeStamp': timeStamp
    };
  }

  @override
  String toString() => 'OTPModel<$id>';
}
