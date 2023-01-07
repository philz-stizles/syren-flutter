import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class BloodSugarService extends GetxService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;
  //
  @override
  void onInit() {
    userId = auth.currentUser!.uid;
    super.onInit();
  }

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('bloodSugars');

  // Future<BloodSugarService> init() async {
  //   // _firestore = FirebaseFirestore.instance;

  //   return this;
  // }

  Future<bool> createByUser(BloodSugarModel bp) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('bloodSugars')
          .add(bp.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<bool> create(BloodSugarModel bp) async {
    try {
      await collection.doc().set(bp.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<BloodSugarModel?> get(String uId) async {
    try {
      DocumentSnapshot doc = await collection.doc(uId).get();
      return BloodSugarModel.fromDocumentSnapshot(doc);
    } catch (e) {
      rethrow;
    }
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future update(String documentId, BloodSugarModel bp) async {
    await collection.doc(documentId).update(bp.toJson());
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future updateByUser(String documentId, BloodSugarModel bp) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('bloodSugars')
        .doc(documentId)
        .update(bp.toJson());
  }

  // adds or updates an existing entry (missing fields will be deleted on
  // update!), document will be created if needed
  Future updateOrAdd(String documentId, BloodSugarModel bp) async {
    await collection.doc(documentId).set(bp.toJson());
  }

  Future<List<BloodSugarModel>> list(String userId) async {
    return (await FirebaseFirestore.instance
            .collection('bloodSugars')
            .where("userId", isEqualTo: userId)
            .orderBy("timeStamp", descending: true)
            .get())
        .docs
        .map((item) => BloodSugarModel.fromJson(item.data()))
        .toList();
  }

  Stream<List<BloodSugarModel>> stream() {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('bloodSugars')
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs
          .map((e) => BloodSugarModel.fromDocumentSnapshot(e))
          .toList();
    });
  }

  Future delete(String documentId) async =>
      await collection.doc(documentId).delete();

  Future deleteByUser(String documentId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('bloodSugars')
        .doc(documentId)
        .delete();
  }
}
