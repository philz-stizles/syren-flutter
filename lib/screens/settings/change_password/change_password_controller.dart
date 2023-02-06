import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/auth/signin/signin_view.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class ChangePasswordController extends GetxController {
  // Services.
  var authService = Get.put(AuthService());

  // Form.
  final changePassFormKey = GlobalKey<FormState>();
  final currentCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  // Observables.
  var isLoadingChangePassword = false.obs;

  @override
  void onClose() {
    currentCtrl.dispose();
    newCtrl.dispose();
    confirmCtrl.dispose();
    super.onClose();
  }

  Future<void> changePassword() async {
    try {
      isLoadingChangePassword(true);
      await authService.changePassword(password: newCtrl.text.trim());
      UIConfig.showSnackBar(
          message: 'Password was changed successfully',
          backgroundColor: Colors.green);
      await authService.signOut();
      Get.offAllNamed(SignInView.routeName);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingChangePassword(false);
    }
  }
}

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
