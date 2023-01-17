import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  String? id;
  String? userId;
  late double rating;
  String? category;
  String? message;
  late DateTime date;

  FeedbackModel({
    this.id,
    this.userId,
    required this.rating,
    this.category,
    this.message,
    required this.date,
  });

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    rating = json['rating'];
    category = json['category'];
    message = json['message'];
    date = json['date'];
  }

  FeedbackModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    userId = doc['userId'];
    rating = doc['rating'];
    category = doc['category'];
    message = doc['message'];
    date = doc['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['rating'] = rating;
    data['category'] = category;
    data['message'] = message;
    data['date'] = date;

    return data;
  }
}
