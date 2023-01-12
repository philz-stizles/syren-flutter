import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:syren/models/email_model.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/screens/dashboard/dashboard.dart';
import 'package:syren/services/email_service.dart';
import 'package:syren/widgets/widgets.dart';

class SignInController extends GetxController {
  // Services.
  var emailService = Get.put(EmailService());

  // Providers.
  var authProvider = Get.put(AuthProvider());

  // Form.
  final emailCtrl = TextEditingController();
  final passwordController = TextEditingController();

  // Observables.
  var isLoadingSignIn = false.obs;

  @override
  void onInit() {
    emailCtrl.text = (Get.arguments != null) ? Get.arguments['email'] : '';
    super.onInit();
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signIn() async {
    try {
      emailService.sendMail(EmailModel(
          to: emailCtrl.text.trim(),
          subject: 'Email Verification',
          message: ''));
      isLoadingSignIn(true);
      await authProvider.signIn(
          email: emailCtrl.text.trim(),
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
      print(error);
      UIConfig.showSnackBar(
          message: error.toString(), backgroundColor: Colors.red);
    }
  }
}
