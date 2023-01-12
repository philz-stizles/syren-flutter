import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class MedicalRecordEditController extends GetxController {
  var userService = Get.put(UserService());

  // Data.
  var religionTypes = ['Christian', 'Muslim', 'Other'];
  var genderTypes = ['Male', 'Female'];
  var alleries = ['Yes', 'No'];
  var conditions = ['Yes', 'No'];
  var genoTypes = ['AA', 'AS', 'SS'];
  var bloodGroups = ['O+', 'AB+', 'A+', 'AB-', 'B+'];

  // Form.
  final signUpFormKey = GlobalKey<FormState>();
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
    hasAllergiesDropdownValue.value = alleries[0];
    hasConditionsDropdownValue.value = conditions[0];
    genoTypeDropdownValue.value = genoTypes[0];
    bloodGroupDropdownValue.value = bloodGroups[0];
    super.onInit();
  }

  @override
  void onClose() {
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
          hasAllergies: true,
          allergies: allergiesCtrl.text.trim(),
          medications: medicationsCtrl.text.trim(),
          hasMedicalConditions: true,
          medicalConditions: conditionsCtrl.text.trim(),
          genoType: genoTypeCtrl.text.trim(),
          bloodGroup: bloodGroupCtrl.text.trim());
      debugPrint(userModel.toJson().toString());

      UIConfig.showSnackBar(
          message: 'Signup was successful', backgroundColor: Colors.green);
    } catch (e) {
      // debugPrint(e.message);
      // if (e.message != null) {
      //   UIConfig.showSnackBar(
      //       message: e.message as String, backgroundColor: Colors.red);
      // }
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
}

class MedicalRecordEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicalRecordEditController());
  }
}
