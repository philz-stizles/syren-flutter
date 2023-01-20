import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? id;
  String? createdBy;
  String? to;
  late String message;
  late Timestamp createdAt;

  ChatModel({
    this.id,
    required this.createdBy,
    required this.message,
    required this.createdAt,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    to = json['to'];
  }

  ChatModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    message = doc['message'];
    createdAt = doc['createdAt'];
    createdBy = doc['createdBy'];
    to = doc['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['to'] = to;

    return data;
  }

  @override
  String toString() => 'ChatModel<$id>';
}
