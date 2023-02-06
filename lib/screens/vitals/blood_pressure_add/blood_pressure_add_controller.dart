import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class BloodPressureAddController extends GetxController {
  // Services.
  var firestoreService = Get.put(FirestoreService<BloodPressureModel>(
      'bloodPressures',
      fromDS: (p0, p1) => BloodPressureModel.fromJson(p1!)));

  // Form.
  final systolicCtrl = TextEditingController();
  final diastolicCtrl = TextEditingController();

  // Observables.
  var isLoadingSaveBp = false.obs;

  @override
  void onClose() {
    systolicCtrl.dispose();
    diastolicCtrl.dispose();
    super.onClose();
  }

  Future<void> saveBp() async {
    try {
      isLoadingSaveBp(true);
      var isSuccess = await firestoreService.createByUser(BloodPressureModel(
          systolic: int.parse(systolicCtrl.text),
          diastolic: int.parse(diastolicCtrl.text),
          timeStamp: Timestamp.now()));
      if (isSuccess) {
        systolicCtrl.clear();
        diastolicCtrl.clear();
        Get.back();
        UIConfig.showSnackBar(
            message: 'Blood pressure was saved successfully',
            backgroundColor: Colors.green);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingSaveBp(false);
    }
  }
}

class BloodPressureAddBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BloodPressureAddController());
  }
}
