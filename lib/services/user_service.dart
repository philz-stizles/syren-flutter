import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class UserService extends GetxService {
  var firestoreSrv = Get.put(FirestoreService<UserModel>(
    'users',
    fromDS: (p0, p1) => (p1 == null) ? UserModel() : UserModel.fromJson(p1),
    toMap: (model) => model.toJson(),
  ));
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;
  String? email;

  @override
  void onInit() {
    userId = auth.currentUser?.uid;
    email = auth.currentUser?.email;
    super.onInit();
  }

  Future<bool> create(UserModel user) async {
    try {
      await firestoreSrv.createItem(user, id: user.id);
      // await firestore.collection('users').doc(user.id).set(user.toJson());
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
      debugPrintStack();
      rethrow;
    }
  }

  Future<bool> checkIfUserExists() async {
    try {
      var user = await firestoreSrv.getQuery();
      return user == null ? false : true;
    } catch (e) {
      debugPrintStack();
      rethrow;
    }
  }

  Stream<UserModel> getUserStream() {
    return firestoreSrv.streamSingle(userId!);
    // return firestore
    //     .collection('users')
    //     .doc(userId)
    //     .snapshots()
    //     .map((snapshot) {
    //   return UserModel.fromDocumentSnapshot(snapshot.id, snapshot.data());
    // });
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

  Stream<List<UserModel>> getAccounts() {
    try {
      return firestoreSrv.streamQueryList(args: [QueryArgs('parent', email)]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      return await firestoreSrv.delete(userId!);
    } catch (e) {
      rethrow;
    }
  }
}
