import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class ChatService extends GetxService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  String? userId;
  //
  @override
  void onInit() {
    userId = fireAuth.currentUser!.uid;
    super.onInit();
  }

  Future<bool> add(ChatModel model) async {
    try {
      model.createdBy = userId;
      model.to = (await getAdminUser()).id;
      await fireStore
          .collection('chats')
          .doc(userId)
          .collection('chats')
          .add(model.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getAdminUser() async {
    try {
      return (await fireStore
              .collection('users')
              .where('role', isEqualTo: 'admin')
              .get())
          .docs
          .first;
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> stream() {
    try {
      return fireStore
          .collection('chats')
          .doc(userId)
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }
}
