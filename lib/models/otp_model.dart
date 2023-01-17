import 'package:cloud_firestore/cloud_firestore.dart';

class OTPModel {
  String? id;
  String? userId;
  String? code;
  Timestamp? expiresAt;
  late Timestamp timeStamp;

  OTPModel(
      {this.id,
      this.userId,
      this.code,
      required this.expiresAt,
      required this.timeStamp});

  // String get codeDisplay => '${code}mmHg';
  // String get expiresAtDisplay => '${expiresAt}mmHg';
  // String get bp => '$code/${expiresAt}mmHg';
  // String formatedTimeStamp(String format) =>
  //     DateFormat(format).format(timeStamp.toDate());

  OTPModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    expiresAt = json['expiresAt'];
    timeStamp = json['timeStamp'];
  }

  OTPModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    code = doc['code'];
    expiresAt = doc['expiresAt'];
    timeStamp = doc['timeStamp'];
  }

  // OTPModel.fromQuerySnapshot(QuerySnapshot query) {
  //   id = query.;
  //   code = doc['code'];
  //   expiresAt = doc['expiresAt'];
  //   timeStamp = doc['timeStamp'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['expiresAt'] = expiresAt;
    data['timeStamp'] = timeStamp;

    return data;
  }

  @override
  String toString() => 'OTPModel<$id>';
}
