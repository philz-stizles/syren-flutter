import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/screens/dashboard/dashboard.dart';
import 'package:syren/widgets/widgets.dart';

class SignInController extends GetxController {
  // Providers.
  var authProvider = Get.put(AuthProvider());

  // Form.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables.
  var isLoadingSignIn = false.obs;

  @override
  void onInit() {
    emailController.text =
        (Get.arguments != null) ? Get.arguments['email'] : '';
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signIn() async {
    try {
      isLoadingSignIn(true);
      await authProvider.signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Get.to(DashboardScreen());
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
