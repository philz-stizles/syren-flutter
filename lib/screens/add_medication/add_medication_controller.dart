import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/widgets/widgets.dart';

class AddMedicationController extends GetxController {
  // Providers.
  var authProvider = Get.put(AuthProvider());

  // Observables.
  var isLoadingDrugs = false.obs;

  @override
  Future<void> onInit() async {
    await loadDrugs();
    super.onInit();
  }

  Future<void> loadDrugs() async {
    try {
      isLoadingDrugs(true);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingDrugs(false);
    }
  }
}

class AddMedicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMedicationController());
  }
}
