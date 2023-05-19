import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/services/user_service.dart';
import 'package:syren/widgets/widgets.dart';

class MedicalRecordEditController extends GetxController {
  // Services.
  var userSrv = Get.find<UserService>();

  // Controllers.
  var userCtrl = Get.find<UserService>();

  // Data.
  var religionTypes = ['Christian', 'Muslim', 'Other'];
  var genderTypes = ['Male', 'Female'];
  var alleries = ['Yes', 'No'];
  var conditions = ['Yes', 'No'];
  var genoTypes = ['AA', 'AS', 'SS'];
  var bloodGroups = ['O+', 'AB+', 'A+', 'AB-', 'B+'];

  // Form.
  final allergiesCtrl = TextEditingController();
  final medicationsCtrl = TextEditingController();
  final conditionsCtrl = TextEditingController();
  final genoTypeCtrl = TextEditingController();
  final bloodGroupCtrl = TextEditingController();

  // Observables.
  RxBool isLoading = false.obs;
  Rxn<String> hasAllergiesDropdown = Rxn<String>();
  Rxn<String> hasConditionsDropdown = Rxn<String>();
  Rxn<String> genoTypeDropdown = Rxn<String>();
  Rxn<String> bloodGroupDropdown = Rxn<String>();

  @override
  void onInit() {
    // Initialize input fields.
    allergiesCtrl.text = userCtrl.user!.allergies ?? '';
    medicationsCtrl.text = userCtrl.user!.medications ?? '';
    conditionsCtrl.text = userCtrl.user!.medicalConditions ?? '';
    genoTypeCtrl.text = userCtrl.user!.genoType ?? '';
    bloodGroupCtrl.text = userCtrl.user!.bloodGroup ?? '';

    hasAllergiesDropdown.value =
        userCtrl.user!.hasAllergies! == true ? 'Yes' : 'No';
    hasConditionsDropdown.value =
        userCtrl.user!.hasMedicalConditions! == true ? 'Yes' : 'No';
    genoTypeDropdown.value = userCtrl.user!.genoType;
    bloodGroupDropdown.value = userCtrl.user!.bloodGroup;
    super.onInit();
  }

  @override
  void onClose() {
    allergiesCtrl.dispose();
    medicationsCtrl.dispose();
    conditionsCtrl.dispose();
    genoTypeCtrl.dispose();
    bloodGroupCtrl.dispose();
    super.onClose();
  }

  Future<void> saveMedRecords() async {
    try {
      isLoading(true);
      var userMap = {
        'hasAllergies': hasAllergiesDropdown.value != null &&
            hasAllergiesDropdown.value?.toLowerCase() == 'yes',
        'hasMedicalConditions':
            hasConditionsDropdown.value?.toLowerCase() == 'yes',
        'allergies': allergiesCtrl.text.trim(),
        'medications': medicationsCtrl.text.trim(),
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
      isLoading(false);
    }
  }
}

class MedicalRecordEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicalRecordEditController());
  }
}
