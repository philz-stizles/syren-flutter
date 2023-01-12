import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class DrugService extends GetxService {
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
      FirebaseFirestore.instance.collection('drugs');

  // Future<DrugService> init() async {
  //   // _firestore = FirebaseFirestore.instance;

  //   return this;
  // }

  Future<bool> create(DrugModel model) async {
    try {
      await collection.doc().set(model.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<DrugModel?> get(String uId) async {
    try {
      DocumentSnapshot doc = await collection.doc(uId).get();
      return DrugModel.fromDocumentSnapshot(doc);
    } catch (e) {
      rethrow;
    }
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future update(String documentId, DrugModel model) async {
    await collection.doc(documentId).update(model.toJson());
  }

  // adds or updates an existing entry (missing fields will be deleted on
  // update!), document will be created if needed
  Future updateOrAdd(String documentId, DrugModel model) async {
    await collection.doc(documentId).set(model.toJson());
  }

  Future<List<DrugModel>> list(String userId) async {
    return (await FirebaseFirestore.instance
            .collection('drugs')
            .orderBy("timeStamp", descending: true)
            .get())
        .docs
        .map((item) => DrugModel.fromJson(item.data()))
        .toList();
  }

  Stream<List<DrugModel>> stream() {
    return firestore
        .collection('drugs')
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs.map((e) => DrugModel.fromDocumentSnapshot(e)).toList();
    });
  }

  Future delete(String documentId) async =>
      await collection.doc(documentId).delete();
}
