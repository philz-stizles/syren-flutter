import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';
import 'package:syren/templates/email/signup_otp.dart';

class OTPService extends GetxService {
  // Services.
  var emailService = Get.find<EmailService>();
  var firestoreSrv = Get.put(FirestoreService<OTPModel>(
    'otps',
    fromDS: (p0, p1) => OTPModel.fromJson(p1!),
  ));

  Future<void> generateOTP({required String email}) async {
    try {
      // Generate OTP.
      var otpCode = (Random.secure().nextInt(1000) + 1000).toString();

      // Store OTP.
      await firestoreSrv.createItem(OTPModel(
          email: email,
          expiresAt: DateTime.now().add(const Duration(minutes: 5)),
          timeStamp: Timestamp.now(),
          code: otpCode));

      // Send OTP.
      emailService.sendMail(
          EmailModel(to: email, subject: 'Email Verification', message: ''),
          SignUpOTPTemplate.template
              .replaceAll('{{EMAIL}}', email)
              .replaceAll('{{CODE}}', otpCode));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> validateOTP(
      {required String email, required String code}) async {
    try {
      var now = DateTime.now();
      // Validate OTP.
      var otps = await firestoreSrv.getQueryList(
          args: [QueryArgs('email', email), QueryArgs('code', code)]);

      return (otps.firstWhereOrNull((element) {
                return element.expiresAt!.isAfter(now);
              })) ==
              null
          ? false
          : true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
