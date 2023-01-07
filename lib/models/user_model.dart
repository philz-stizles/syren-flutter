import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? gender;
  String? religion;
  String? phone;
  String? dob;
  bool? hasAllergies;
  String? allergies;
  String? medications;
  bool? hasMedicalConditions;
  String? medicalConditions;
  String? genoType;
  String? bloodGroup;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.gender,
      this.religion,
      this.phone,
      this.dob,
      this.hasAllergies,
      this.allergies,
      this.medications,
      this.hasMedicalConditions,
      this.medicalConditions,
      this.genoType,
      this.bloodGroup});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    religion = json['religion'];
    phone = json['phone'];
    dob = json['dob'];
    hasAllergies = json['hasAllergies'];
    allergies = json['allergies'];
    hasMedicalConditions = json['hasMedicalConditions'];
    medicalConditions = json['medicalConditions'];
    genoType = json['genoType'];
    bloodGroup = json['bloodGroup'];
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    name = doc['name'];
    email = doc['email'];
    gender = doc['gender'];
    religion = doc['religion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['religion'] = religion;
    data['phone'] = phone;
    data['dob'] = dob;
    data['hasAllergies'] = hasAllergies;
    data['allergies'] = allergies;
    data['hasMedicalConditions'] = hasMedicalConditions;
    data['medications'] = medications;
    data['medicalConditions'] = medicalConditions;
    data['genoType'] = genoType;
    data['bloodGroup'] = bloodGroup;
    return data;
  }
}
