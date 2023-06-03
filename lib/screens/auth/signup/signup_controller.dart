import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class SignUpController extends GetxController {
  var authProvider = Get.put(AuthProvider());

  // Services.
  var authService = Get.put(AuthService());
  var userSrv = Get.put(UserService());
  var otpSrv = Get.put(OTPService());

  // Data.
  var religionTypes = ['Christian', 'Muslim', 'Other'];
  var genderTypes = ['Male', 'Female'];
  var allergies = ['Yes', 'No'];
  var conditions = ['Yes', 'No'];
  var genoTypes = ['AA', 'AS', 'SS'];
  var bloodGroups = ['O+', 'AB+', 'A+', 'AB-', 'B+'];
  String? parent;

  // Form.
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final emailKey = GlobalKey<FormFieldState>();
  final dobCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final allergiesCtrl = TextEditingController();
  final medicationsCtrl = TextEditingController();
  final hasConditionsCtrl = TextEditingController();
  final conditionsCtrl = TextEditingController();

  // Observables.
  var emailExists = false.obs;
  var isCheckingEmail = false.obs;
  var isLoadingSignUp = false.obs;
  var genderDropdownValue = Rxn<String>();
  var religionDropdownValue = Rxn<String>();
  var allergiesDropdownValue = Rxn<String>();
  var conditionsDropdownValue = Rxn<String>();
  var genoTypeDropdownValue = Rxn<String>();
  var bloodGroupDropdownValue = Rxn<String>();
  var phoneCountryCode = Rxn<String>();

  @override
  void onInit() {
    if (Get.arguments != null) {
      parent = Get.arguments['parent'];
    }
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    dobCtrl.dispose();
    passwordCtrl.dispose();
    allergiesCtrl.dispose();
    medicationsCtrl.dispose();
    hasConditionsCtrl.dispose();
    conditionsCtrl.dispose();

    super.onClose();
  }

  Future<void> signUp() async {
    try {
      isLoadingSignUp(true);
      var userModel = UserModel(
          parent: parent,
          email: emailCtrl.text.trim(),
          name: nameCtrl.text.trim(),
          gender: genderDropdownValue.value,
          religion: religionDropdownValue.value,
          phone: phoneCtrl.text.trim(),
          dob: dobCtrl.text,
          hasAllergies: allergiesDropdownValue.value != null &&
              allergiesDropdownValue.value?.toLowerCase() == 'yes',
          allergies: allergiesCtrl.text.trim(),
          medications: medicationsCtrl.text.trim(),
          hasMedicalConditions:
              conditionsDropdownValue.value?.toLowerCase() == 'yes',
          medicalConditions: medicationsCtrl.text.trim(),
          genoType: genoTypeDropdownValue.value,
          bloodGroup: bloodGroupDropdownValue.value);
      await authProvider.signUp(
          userModel: userModel, password: passwordCtrl.text.trim());
      if (userSrv.authUser.value == null) {
        UIConfig.showSnackBar(
            message: 'Signup was successful', backgroundColor: Colors.green);
        // Get.offAll(DashboardScreen());
        Get.offAllNamed(SignInView.routeName,
            arguments: {'email': userModel.email});
      } else {
        Get.back();
        Get.back();
        Get.back();
      }
      // Get.offNamed(SignInView.routeName, arguments: {'email': userModel.email});
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      debugPrint(e.message);
      Get.back();
      Get.back();
      Get.back();
      // Get.offNamed(SignUpView.routeName);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String,
            backgroundColor: Colors.red,
            duration: const Duration(minutes: 30));
      }
    } on HttpException catch (e) {
      Get.back();
      Get.back();
      Get.back();
      // Get.offNamed(SignUpView.routeName);
      UIConfig.showSnackBar(
          message: e.message,
          backgroundColor: Colors.red,
          duration: const Duration(minutes: 5));
    } finally {
      isLoadingSignUp(false);
    }
  }

  Future<void> otpVerification() async {
    try {
      isLoadingSignUp(true);
      var email = emailCtrl.text.trim();

      // Generate OTP.
      await otpSrv.generateOTP(email: email);

      // Navigate to OTP Screen.
      Get.toNamed(OtpView.routeName, arguments: {'email': email});
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingSignUp(false);
    }
  }
}

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
