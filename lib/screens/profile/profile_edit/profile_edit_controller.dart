import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/controllers/user_controller.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class ProfileEditController extends GetxController {
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
  final signUpFormKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final religionCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final hasAllergiesCtrl = TextEditingController();
  final allergiesCtrl = TextEditingController();
  final medicationsCtrl = TextEditingController();
  final hasConditionsCtrl = TextEditingController();
  final conditionsCtrl = TextEditingController();
  final genoTypeCtrl = TextEditingController();
  final bloodGroupCtrl = TextEditingController();

  // Observables.
  var isLoadingSaveProfile = false.obs;
  var genderDropdownValue = ''.obs;
  var religionDropdownValue = ''.obs;
  var hasAllergiesDropdownValue = ''.obs;
  var hasConditionsDropdownValue = ''.obs;
  var genoTypeDropdownValue = ''.obs;
  var bloodGroupDropdownValue = ''.obs;

  @override
  void onInit() {
    nameCtrl.text = userCtrl.user!.name ?? '';
    phoneCtrl.text = userCtrl.user!.phone ?? '';
    emailCtrl.text = userCtrl.user!.email ?? '';
    dobCtrl.text = userCtrl.user!.dob ?? '';
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
    dobCtrl.dispose();
    hasAllergiesCtrl.dispose();
    allergiesCtrl.dispose();
    medicationsCtrl.dispose();
    hasConditionsCtrl.dispose();
    conditionsCtrl.dispose();
    genoTypeCtrl.dispose();
    bloodGroupCtrl.dispose();
    super.onClose();
  }

  Future<void> saveProfile() async {
    try {
      isLoadingSaveProfile(true);
      var userMap = {
        'email': emailCtrl.text.trim(),
        'name': nameCtrl.text.trim(),
        'gender': genderCtrl.text.trim(),
        'religion': religionCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'dob': dobCtrl.text
      };
      debugPrint(userMap.toString());
      await userSrv.update(userMap);

      UIConfig.showSnackBar(
          message: 'Profile updated successfully',
          backgroundColor: Colors.green);
    } catch (e) {
      // debugPrint(e.message);
      // if (e.message != null) {
      //   UIConfig.showSnackBar(
      //       message: e.message as String, backgroundColor: Colors.red);
      // }
    } finally {
      isLoadingSaveProfile(false);
    }
  }
}

class ProfileEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileEditController());
  }
}
