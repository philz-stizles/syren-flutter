import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/auth/signup/signup_controller.dart';
import 'package:syren/services/services.dart';
import 'package:syren/utils/formatters.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class OtpController extends GetxController {
  // Servives.
  var otpSrv = Get.put(OTPService());

  // Controllers.
  var signUpCtrl = Get.find<SignUpController>();

  // Data.
  dynamic argumentData = Get.arguments;

  // Form.
  final otpFormKey = GlobalKey<FormState>();
  final pin1Ctrl = TextEditingController();
  final pin2Ctrl = TextEditingController();
  final pin3Ctrl = TextEditingController();
  final pin4Ctrl = TextEditingController();
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  // Observables.
  var isLoadingOtp = false.obs;
  var isLoadingValidateOtp = false.obs;
  var isLoadingGenerateOtp = false.obs;
  var timer = Rxn<Timer>();
  var duration = Rxn<Duration>();

  @override
  void onInit() {
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

    _startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    pin1Ctrl.dispose();
    pin2Ctrl.dispose();
    pin3Ctrl.dispose();
    pin4Ctrl.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();

    _stopTimer();

    super.onClose();
  }

  void _startTimer() {
    duration.value = const Duration(minutes: 5);
    timer.value =
        Timer.periodic(const Duration(seconds: 1), (_) => _setCountDown());
  }

  void _stopTimer() {
    timer.value?.cancel();
  }

  void _setCountDown() {
    const reduceSecondsBy = 1;

    final seconds = duration.value!.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      timer.value!.cancel();
    } else {
      duration.value = Duration(seconds: seconds);
    }
  }

  String getOTPExpiry(Duration? duration) {
    var hours = Formatter.strDigits(duration!.inHours.remainder(24));
    var minutes = Formatter.strDigits(duration.inMinutes.remainder(60));
    var seconds = Formatter.strDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  Future<void> generateOTP({required String email}) async {
    try {
      isLoadingGenerateOtp(true);

      // Generate OTP.
      await otpSrv.generateOTP(email: email);

      _startTimer();

      pin1Ctrl.text = '';
      pin2Ctrl.text = '';
      pin3Ctrl.text = '';
      pin4Ctrl.text = '';

      UIConfig.showSnackBar(
          message: 'Verification code has been sent to\n $email',
          backgroundColor: Colors.green);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingGenerateOtp(false);
    }
  }

  Future<void> validateOTP(
      {required String email, required String code}) async {
    try {
      isLoadingValidateOtp(true);

      // Validate OTP.
      var isValid = await otpSrv.validateOTP(email: email, code: code);
      if (!isValid) {
        UIConfig.showSnackBar(
            message: 'Verification Failed', backgroundColor: Colors.red);
      } else {
        UIConfig.showBottomSheet(
            Obx(
              () => Column(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Palette.primary,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Your email has been verified successfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                      disabled: signUpCtrl.isLoadingSignUp.value,
                      loading: signUpCtrl.isLoadingSignUp.value,
                      title: 'Complete Registration',
                      press: () async {
                        await signUpCtrl.signUp();
                      })
                ],
              ),
            ),
            isDismissible: false);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingValidateOtp(false);
    }
  }
}

class OtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
