import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/medication_service.dart';
import 'package:syren/widgets/widgets.dart';

class MedicationsController extends GetxController {
  // Providers.
  var medicationSrv = Get.put(MedicationService());

  // Observables.
  Rx<List<MedicationModel>> medList = Rx<List<MedicationModel>>([]);
  List<MedicationModel> get meds => medList.value;
  var isLoadingMedications = false.obs;
  var selectedPageIndex = 0.obs;

  // @override
  // Future<void> onInit() async {
  //   await loadMedications();
  //   super.onInit();
  // }

  @override
  void onReady() {
    medList.bindStream(medicationSrv.stream());
    super.onReady();
  }

  Future<void> loadMedications() async {
    try {
      isLoadingMedications(true);
      await medicationSrv.list();
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
