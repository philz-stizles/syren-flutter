import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/controllers/user_controller.dart';
import 'package:syren/services/user_service.dart';
import 'package:syren/widgets/widgets.dart';

class MedicalRecordEditController extends GetxController {
  // Services.
  var userSrv = Get.find<UserService>();

  // Controllers.
  var userCtrl = Get.find<UserController>();

  // Data.
  var religionTypes = ['Christian', 'Muslim', 'Other'];
  var genderTypes = ['Male', 'Female'];
  var alleries = ['Yes', 'No'];
  var conditions = ['Yes', 'No'];
  var genoTypes = ['AA', 'AS', 'SS'];
  var bloodGroups = ['O+', 'AB+', 'A+', 'AB-', 'B+'];

  // Form.
  final hasAllergiesCtrl = TextEditingController();
  final allergiesCtrl = TextEditingController();
  final medicationsCtrl = TextEditingController();
  final hasConditionsCtrl = TextEditingController();
  final conditionsCtrl = TextEditingController();
  final genoTypeCtrl = TextEditingController();
  final bloodGroupCtrl = TextEditingController();

  // Observables.
  var isLoadingSaveMedRecords = false.obs;
  var genderDropdownValue = ''.obs;
  var religionDropdownValue = ''.obs;
  var hasAllergiesDropdownValue = ''.obs;
  var hasConditionsDropdownValue = ''.obs;
  var genoTypeDropdownValue = ''.obs;
  var bloodGroupDropdownValue = ''.obs;

  @override
  void onInit() {
    // Initialize input fields.
    if (userCtrl.user != null && userCtrl.user?.hasAllergies != null) {
      hasAllergiesCtrl.text =
          userCtrl.user!.hasAllergies! == true ? 'Yes' : 'No';
    }

    if (userCtrl.user != null && userCtrl.user!.hasMedicalConditions != null) {
      hasConditionsCtrl.text =
          userCtrl.user!.hasMedicalConditions! == true ? 'Yes' : 'No';
    }

    allergiesCtrl.text = userCtrl.user!.allergies ?? '';
    medicationsCtrl.text = userCtrl.user!.medications ?? '';
    conditionsCtrl.text = userCtrl.user!.medicalConditions ?? '';
    genoTypeCtrl.text = userCtrl.user!.genoType ?? '';
    bloodGroupCtrl.text = userCtrl.user!.bloodGroup ?? '';

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

  Future<void> saveMedRecords() async {
    try {
      isLoadingSaveMedRecords(true);
      var userMap = {
        'hasAllergies': true,
        'allergies': allergiesCtrl.text.trim(),
        'medications': medicationsCtrl.text.trim(),
        'hasMedicalConditions': true,
        'medicalConditions': conditionsCtrl.text.trim(),
        'genoType': genoTypeCtrl.text.trim(),
        'bloodGroup': bloodGroupCtrl.text.trim()
      };
      await userSrv.update(userMap);

      // Get.off(SuccessView(
      //     message: 'You have successfully updated\n your medical records.',
      //     title: 'Profile',
      //     backToPage: ProfileView.routeName));

      UIConfig.showSnackBar(
          message: 'Profile updated successfully',
          backgroundColor: Colors.green);

      // Get.back();
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingSaveMedRecords(false);
    }
  }
}

class MedicalRecordEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicalRecordEditController());
  }
}
