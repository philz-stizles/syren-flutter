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
      return UserModel.fromDocumentSnapshot(doc.id, docData);
    } catch (e) {
      rethrow;
    }
  }

  Stream<UserModel> getUserStream() {
    return firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      return UserModel.fromDocumentSnapshot(snapshot.id, snapshot.data());
    });
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future<void> update(Map<String, dynamic> userMap) async {
    try {
      await firestore.collection('users').doc(userId).update(userMap);
    } catch (e) {
      rethrow;
    }
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future updateByUser(String documentId, BloodPressureModel bp) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('bloodPressures')
        .doc(documentId)
        .update(bp.toJson());
  }
}
