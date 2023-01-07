import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class BloodSugarAddController extends GetxController {
  // Services.
  var bpService = Get.put(BloodSugarService());

  // Form.
  final fastingCtrl = TextEditingController();
  final randomCtrl = TextEditingController();

  // Observables.
  var isLoadingSaveBs = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    fastingCtrl.dispose();
    randomCtrl.dispose();
    super.onClose();
  }

  Future<void> saveBp() async {
    try {
      isLoadingSaveBs(true);
      var isSuccess = await bpService.createByUser(BloodSugarModel(
          fasting: int.parse(fastingCtrl.text),
          random: int.parse(randomCtrl.text),
          timeStamp: Timestamp.now()));
      if (isSuccess) {
        fastingCtrl.clear();
        randomCtrl.clear();
        UIConfig.showSnackBar(
            message: 'Blood Sugar was saved successfully',
            backgroundColor: Colors.green);
        Get.toNamed(BloodSugarView.routeName);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingSaveBs(false);
    }
  }
}

class BloodSugarAddBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BloodSugarAddController());
  }
}
