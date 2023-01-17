import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class OTPService extends GetxService {
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
      FirebaseFirestore.instance.collection('OTPs');

  // Future<OTPService> init() async {
  //   // _firestore = FirebaseFirestore.instance;

  //   return this;
  // }

  Future<bool> createByUser(OTPModel bp) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('OTPs')
          .add(bp.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<bool> create(OTPModel bp) async {
    try {
      await collection.doc().set(bp.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  // Future<OTPModel?> get(
  //     {required String code, required String expiresAt}) async {
  //   try {
  //     QuerySnapshot<Object?> doc =
  //         await collection.where('code', isEqualTo: code).get().;
  //     return OTPModel.fromDocumentSnapshot(doc);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future update(String documentId, OTPModel bp) async {
    await collection.doc(documentId).update(bp.toJson());
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future updateByUser(String documentId, OTPModel bp) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('OTPs')
        .doc(documentId)
        .update(bp.toJson());
  }

  // adds or updates an existing entry (missing fields will be deleted on
  // update!), document will be created if needed
  Future updateOrAdd(String documentId, OTPModel bp) async {
    await collection.doc(documentId).set(bp.toJson());
  }

  Future<List<OTPModel>> list(String userId) async {
    return (await FirebaseFirestore.instance
            .collection('OTPs')
            .where("userId", isEqualTo: userId)
            .orderBy("timeStamp", descending: true)
            .get())
        .docs
        .map((item) => OTPModel.fromJson(item.data()))
        .toList();
  }

  Stream<List<OTPModel>> stream() {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('OTPs')
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs.map((e) => OTPModel.fromDocumentSnapshot(e)).toList();
    });
  }

  Future delete(String documentId) async =>
      await collection.doc(documentId).delete();

  Future deleteByUser(String documentId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('OTPs')
        .doc(documentId)
        .delete();
  }
}
