import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? id;
  String? imageLocation;
  String? title;
  String? pills;
  String? time;
  String? when;

  ReviewModel({
    this.id,
    this.imageLocation,
    this.title,
    this.pills,
    this.time,
    this.when,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    pills = json['pills'];
    time = json['time'];
    when = json['when'];
  }

  ReviewModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    imageLocation = doc['imageLocation'];
    title = doc['title'];
    pills = doc['pills'];
    time = doc['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageLocation'] = imageLocation;
    data['title'] = title;
    data['pills'] = pills;
    data['time'] = time;
    data['when'] = when;

    return data;
  }
}
