import 'package:cloud_firestore/cloud_firestore.dart';

class EmailModel {
  String? id;
  String? from;
  late String to;
  late String subject;
  late String message;
  String? ccRecipient;
  List<String>? ccRecipients;
  String? bccRecipient;
  List<String>? bccRecipients;

  EmailModel({
    this.id,
    this.from,
    required this.to,
    required this.subject,
    required this.message,
    this.ccRecipient,
    this.bccRecipient,
  });

  EmailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    subject = json['subject'];
    message = json['message'];
    ccRecipient = json['ccRecipient'];
    bccRecipient = json['bccRecipient'];
  }

  EmailModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    from = doc['from'];
    to = doc['to'];
    subject = doc['subject'];
    message = doc['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['subject'] = subject;
    data['message'] = message;
    data['ccRecipient'] = ccRecipient;
    data['bccRecipient'] = bccRecipient;

    return data;
  }
}
