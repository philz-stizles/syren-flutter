import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/signin/signin_view.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class SignUpController extends GetxController {
  var authService = Get.put(AuthService());

  // Data.
  var religionTypes = ['Christian', 'Muslim', 'Other'];
  var genderTypes = ['Male', 'Female'];
  var alleries = ['Yes', 'No'];
  var conditions = ['Yes', 'No'];
  var genoTypes = ['AA', 'AS', 'SS'];
  var bloodGroups = ['O+', 'AB+', 'A+', 'AB-', 'B+'];

  // Form.
  final signUpFormKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final religionCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final hasAllergiesCtrl = TextEditingController();
  final allergiesCtrl = TextEditingController();
  final medicationsCtrl = TextEditingController();
  final hasConditionsCtrl = TextEditingController();
  final conditionsCtrl = TextEditingController();
  final genoTypeCtrl = TextEditingController();
  final bloodGroupCtrl = TextEditingController();

  // Observables.
  var isLoadingSignUp = false.obs;
  var genderDropdownValue = ''.obs;
  var religionDropdownValue = ''.obs;
  var hasAllergiesDropdownValue = ''.obs;
  var hasConditionsDropdownValue = ''.obs;
  var genoTypeDropdownValue = ''.obs;
  var bloodGroupDropdownValue = ''.obs;

  @override
  void onInit() {
    genderDropdownValue.value = genderTypes[0];
    genderCtrl.text = genderTypes[0];

    religionDropdownValue.value = religionTypes[0];
    religionCtrl.text = religionTypes[0];

    hasAllergiesDropdownValue.value = alleries[0];
    allergiesCtrl.text = alleries[0];

    hasConditionsDropdownValue.value = conditions[0];
    hasConditionsCtrl.text = conditions[0];

    genoTypeDropdownValue.value = genoTypes[0];
    genoTypeCtrl.text = genoTypes[0];

    bloodGroupDropdownValue.value = bloodGroups[0];
    bloodGroupCtrl.text = bloodGroups[0];
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    genderCtrl.dispose();
    religionCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    dobCtrl.dispose();
    passwordCtrl.dispose();
    hasAllergiesCtrl.dispose();
    allergiesCtrl.dispose();
    medicationsCtrl.dispose();
    hasConditionsCtrl.dispose();
    conditionsCtrl.dispose();
    genoTypeCtrl.dispose();
    bloodGroupCtrl.dispose();
    super.onClose();
  }

  Future<void> signUp() async {
    try {
      isLoadingSignUp(true);
      var userModel = UserModel(
          email: emailCtrl.text.trim(),
          name: nameCtrl.text.trim(),
          gender: genderCtrl.text.trim(),
          religion: religionCtrl.text.trim(),
          phone: phoneCtrl.text.trim(),
          dob: dobCtrl.text,
          hasAllergies: hasAllergiesCtrl.text.toLowerCase() == 'yes',
          allergies: allergiesCtrl.text.trim(),
          medications: medicationsCtrl.text.trim(),
          hasMedicalConditions: hasConditionsCtrl.text.toLowerCase() == 'yes',
          medicalConditions: conditionsCtrl.text.trim(),
          genoType: genoTypeCtrl.text.trim(),
          bloodGroup: bloodGroupCtrl.text.trim());
      await authService.signUp(
          userModel: userModel, password: passwordCtrl.text.trim());
      UIConfig.showSnackBar(
          message: 'Signup was successful', backgroundColor: Colors.green);
      Get.offNamed(SignInView.routeName, arguments: {'email': userModel.email});
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingSignUp(false);
    }
    // checkUser(emailController.text, passwordController.text).then((auth) {
    //   if (auth) {
    //     Get.snackbar('Login', 'Login successfully');
    //   } else {
    //     Get.snackbar('Login', 'Invalid email or password');
    //   }
    //   passwordController.clear();
    // });
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

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
