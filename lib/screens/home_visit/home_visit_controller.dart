import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/widgets/widgets.dart';

class HomeVisitController extends GetxController {
  // Providers.
  var authProvider = Get.put(AuthProvider());

  // Form.
  final systolicController = TextEditingController();
  final diastolicController = TextEditingController();

  // Observables.
  var isLoadingSignIn = false.obs;

  @override
  void onClose() {
    systolicController.dispose();
    diastolicController.dispose();
    super.onClose();
  }

  Future<void> signIn() async {
    try {
      isLoadingSignIn(true);
      await authProvider.signIn(
          email: systolicController.text.trim(),
          password: diastolicController.text.trim());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingSignIn(false);
    }
  }
}
