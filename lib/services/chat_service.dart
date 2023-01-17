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
      await fireStore.collection('chats').add(model.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  // Future<bool> add(BloodPressureModel bp) async {
  //   try {
  //     await collection.doc().set(bp.toJson());
  //     return true;
  //   } catch (e) {
  //     debugPrintStack();
  //     return false;
  //   }
  // }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future updateByUser(String documentId, BloodPressureModel bp) async {
    await fireStore
        .collection('users')
        .doc(userId)
        .collection('bloodPressures')
        .doc(documentId)
        .update(bp.toJson());
  }

  Future<List<BloodPressureModel>> list(String userId) async {
    return (await FirebaseFirestore.instance
            .collection('bloodPressures')
            .where("userId", isEqualTo: userId)
            .orderBy("timeStamp", descending: true)
            .get())
        .docs
        .map((item) => BloodPressureModel.fromJson(item.data()))
        .toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> stream() {
    return fireStore
        .collection('chats')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future delete(String documentId) async =>
      await fireStore.collection('chats').doc(documentId).delete();

  Future deleteByUser(String documentId) async {
    await fireStore
        .collection('users')
        .doc(userId)
        .collection('bloodPressures')
        .doc(documentId)
        .delete();
  }
}
