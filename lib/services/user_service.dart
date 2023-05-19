import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class UserService extends GetxService {
  final firestoreSrv = Get.put(FirestoreService<UserModel>(
    'users',
    fromDS: (p0, p1) => (p1 == null) ? UserModel() : UserModel.fromJson(p1),
    toMap: (model) => model.toJson(),
  ));
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // Observables.
  Rx<UserModel?> userModel = UserModel().obs;
  RxList<UserModel> accounts = <UserModel>[].obs;
  Rxn<User?> authUser = Rxn<User>();

  UserModel? get user => userModel.value;

  set user(UserModel? value) => userModel.value = value;

  @override
  void onInit() {
    print(auth.currentUser?.uid);
    authUser.value = auth.currentUser;
    super.onInit();
  }

  @override
  void onReady() async {
    // user = (await userService.getUser())!;
    if (authUser.value != null) {
      userModel.bindStream(getUserStream());
      accounts.bindStream(getAccounts());
    }
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
      print(authUser.value!.uid);
      DocumentSnapshot<Map<String, dynamic>> doc =
          await firestore.collection('users').doc(authUser.value!.uid).get();
      Map<String, dynamic>? docData = doc.data();
      return UserModel.fromDocumentSnapshot(doc.id, docData);
    } catch (e) {
      debugPrintStack();
      rethrow;
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      var user = await firestoreSrv.getQuery(args: [QueryArgs('email', email)]);
      return user == null ? false : true;
    } catch (e) {
      debugPrintStack();
      rethrow;
    }
  }

  Stream<UserModel> getUserStream() {
    return firestoreSrv.streamSingle(authUser.value!.uid);
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
      await firestore
          .collection('users')
          .doc(authUser.value!.uid)
          .update(userMap);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<UserModel>> getAccounts() {
    try {
      return firestoreSrv.streamQueryList(args: [
        QueryArgs('parent', authUser.value!.email),
        if (user!.parent != null) QueryArgs('email', user!.parent)
      ]);
    } catch (e) {
      rethrow;
    }
  }

  void clear() {
    userModel.value = UserModel();
  }

  Future<void> deleteAccount() async {
    try {
      return await firestoreSrv.delete(authUser.value!.uid);
    } catch (e) {
      rethrow;
    }
  }
}
