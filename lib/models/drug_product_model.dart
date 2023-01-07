import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syren/models/review_model.dart';

class DrugProductModel {
  String? id;
  String? imageLocation;
  String? name;
  String? description;
  List<ReviewModel>? reviews;
  int? price;
  int? quantity;

  DrugProductModel({
    this.id,
    this.imageLocation,
    this.name,
    this.description,
    this.reviews,
    this.price,
    this.quantity,
  });

  DrugProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageLocation = json['imageLocation'];
    name = json['name'];
    description = json['description'];
    reviews = json['reviews'];
    price = json['price'];
    quantity = json['quantity'];
  }

  DrugProductModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    imageLocation = doc['imageLocation'];
    name = doc['name'];
    description = doc['description'];
    reviews = doc['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageLocation'] = imageLocation;
    data['name'] = name;
    data['description'] = description;
    data['reviews'] = reviews;
    data['price'] = price;
    data['quantity'] = quantity;

    return data;
  }
}
