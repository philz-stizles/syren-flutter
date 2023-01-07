import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/widgets/widgets.dart';

class MedicationsController extends GetxController {
  // Providers.
  var authProvider = Get.put(AuthProvider());

  // Observables.
  var isLoadingMedications = false.obs;

  @override
  Future<void> onInit() async {
    await loadMedications();
    super.onInit();
  }

  Future<void> loadMedications() async {
    try {
      isLoadingMedications(true);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingMedications(false);
    }
  }
}

class MedicationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicationsController());
  }
}
