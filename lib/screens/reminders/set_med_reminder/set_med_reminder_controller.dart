import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetMedReminderController extends GetxController {
  // Data.
  var drugTypes = ['Christian', 'Muslim', 'Other'];

  // Form.
  final signUpFormKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final drugTypeCtrl = TextEditingController();
  final timeCtrl = TextEditingController();

  // Observables.
  var isLoadingSetReminder = false.obs;
  var drugTypeDropdownValue = ''.obs;

  @override
  void onInit() {
    drugTypeDropdownValue.value = drugTypes[0];
    drugTypeCtrl.text = drugTypes[0];
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    amountCtrl.dispose();
    drugTypeCtrl.dispose();

    super.onClose();
  }
}

class SetMedReminderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetMedReminderController());
  }
}
