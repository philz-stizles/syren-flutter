import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:syren/screens/dashboard/dashboard_view.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class SignInController extends GetxController {
  // Services.
  var emailService = Get.find<EmailService>();
  var authService = Get.find<AuthService>();

  // Form.
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  // Observables.
  var isLoadingSignIn = false.obs;

  @override
  void onInit() {
    emailCtrl.text = (Get.arguments != null && Get.arguments['email'] != null) 
    ? Get.arguments['email'] 
    : '';
    super.onInit();
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }

  Future<void> signIn({email, password}) async {
    try {
      isLoadingSignIn(true);
      await authService.signIn(email: email, password: password);
      Get.offAll(DashboardScreen());
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String,
            backgroundColor: Colors.red,
            action: GestureDetector(
                onTap: () => Get.back(), child: const Icon(Icons.close)));
      }
    } finally {
      isLoadingSignIn(false);
    }
  }

  Future<void> send() async {
    Random random2 = Random.secure();

    var randomNumber2 = random2.nextInt(1000);
    final Email email = Email(
      body: randomNumber2.toString(),
      subject: 'Email verification code',
      recipients: [emailCtrl.text],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      UIConfig.showSnackBar(
          message: 'Email sent successfully', backgroundColor: Colors.green);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      UIConfig.showSnackBar(
          message: error.toString(), backgroundColor: Colors.red);
    }
  }
}

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
