import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/user_service.dart';

class AuthService extends GetxService {
  Future signUp(
      {required UserModel userModel, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email as String, password: password);
      userModel.id = userCredential.user?.uid;
      var success = await UserService().create(userModel);
      if (success) {
        // Get.find<UserController>().user = userModel;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> changePassword({required String password}) async {
    try {
      // Create an instance of the current user.
      User? user = FirebaseAuth.instance.currentUser;

      //Pass in the password to updatePassword.
      await user?.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<void> deleteAccount({required String password}) async {
    try {
      // Create an instance of the current user.
      User? user = FirebaseAuth.instance.currentUser;

      //Pass in the password to updatePassword.
      await user?.delete();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  // Future<Response> signIn(Map data) => post('http://youapi/users', data);
  // // Post request with File
  // Future<Response<CasesModel>> postCases(List<int> image) {
  //   final form = FormData({
  //     'file': MultipartFile(image, filename: 'avatar.png'),
  //     'otherFile': MultipartFile(image, filename: 'cover.png'),
  //   });
  //   return post('http://youapi/users/upload', form);
  // }

  // GetSocket userMessages() {
  //   return socket('https://yourapi/users/socket');
  // }
}
