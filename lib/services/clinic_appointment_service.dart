import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class ClinicAppointmentService extends GetxService {
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
      FirebaseFirestore.instance.collection('clinicAppointments');

  // Future<ClinicAppointmentService> init() async {
  //   // _firestore = FirebaseFirestore.instance;

  //   return this;
  // }

  Future<bool> createByUser(ClinicAppointmentModel bp) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('clinicAppointments')
          .add(bp.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<bool> create(ClinicAppointmentModel bp) async {
    try {
      await collection.doc().set(bp.toJson());
      return true;
    } catch (e) {
      debugPrintStack();
      return false;
    }
  }

  Future<ClinicAppointmentModel?> get(String uId) async {
    try {
      DocumentSnapshot doc = await collection.doc(uId).get();
      return ClinicAppointmentModel.fromDocumentSnapshot(doc);
    } catch (e) {
      rethrow;
    }
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future update(String documentId, ClinicAppointmentModel bp) async {
    await collection.doc(documentId).update(bp.toJson());
  }

  // updates an existing entry (missing fields won't be touched on update),
  // document must exist
  Future updateByUser(String documentId, ClinicAppointmentModel bp) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('clinicAppointments')
        .doc(documentId)
        .update(bp.toJson());
  }

  // adds or updates an existing entry (missing fields will be deleted on
  // update!), document will be created if needed
  Future updateOrAdd(String documentId, ClinicAppointmentModel bp) async {
    await collection.doc(documentId).set(bp.toJson());
  }

  Future<List<ClinicAppointmentModel>> list() async {
    return (await FirebaseFirestore.instance
            .collection('clinicAppointments')
            .where("userId", isEqualTo: userId)
            .orderBy("timeStamp", descending: true)
            .get())
        .docs
        .map((item) => ClinicAppointmentModel.fromJson(item.data()))
        .toList();
  }

  Stream<List<ClinicAppointmentModel>> stream() {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('clinicAppointments')
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs
          .map((e) => ClinicAppointmentModel.fromDocumentSnapshot(e))
          .toList();
    });
  }

  Future delete(String documentId) async =>
      await collection.doc(documentId).delete();

  Future deleteByUser(String documentId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('clinicAppointments')
        .doc(documentId)
        .delete();
  }
}
