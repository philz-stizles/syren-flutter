import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class UserService extends GetxService {
  final FirebaseFirestore? firestore = FirebaseFirestore.instance;

  // Future<UserService> init() async {
  //   _firestore = FirebaseFirestore.instance;
  //   return this;
  // }

  Future<bool> create(UserModel user) async {
    try {
      await firestore!.collection('users').doc().set(user.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<UserModel?> getUser(String uId) async {
    try {
      DocumentSnapshot doc =
          await firestore!.collection('users').doc(uId).get();
      return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      rethrow;
    }
  }
}
