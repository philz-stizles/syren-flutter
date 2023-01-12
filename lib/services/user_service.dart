import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class UserService extends GetxService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;

  @override
  void onInit() {
    userId = auth.currentUser!.uid;
    super.onInit();
  }

  Future<bool> create(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<UserModel?> getUser() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? docData = doc.data();
      return UserModel.fromDocumentSnapshot(doc, docData);
    } catch (e) {
      rethrow;
    }
  }

  // Stream<List<BloodPressureModel>> stream() {
  //   return firestore!
  //       .collection('users')
  //       .doc(userId).get()
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     return query.docs
  //         .map((e) => BloodPressureModel.fromDocumentSnapshot(e))
  //         .toList();
  //   });
  // }
}
