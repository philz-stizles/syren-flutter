import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/widgets/widgets.dart';

class ProfileEditController extends GetxController {
  var authProvider = Get.put(AuthProvider());

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
    hasConditionsDropdownValue.value = conditions[0];
    genoTypeDropdownValue.value = genoTypes[0];
    bloodGroupDropdownValue.value = bloodGroups[0];
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    genderCtrl.dispose();
    religionCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
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
          dob: '',
          hasAllergies: true,
          allergies: allergiesCtrl.text.trim(),
          medications: medicationsCtrl.text.trim(),
          hasMedicalConditions: true,
          medicalConditions: conditionsCtrl.text.trim(),
          genoType: genoTypeCtrl.text.trim(),
          bloodGroup: bloodGroupCtrl.text.trim());
      debugPrint(userModel.toJson().toString());
      await authProvider.signUp(
          userModel: userModel, password: passwordCtrl.text.trim());
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
  }
}

class ProfileEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileEditController());
  }
}
