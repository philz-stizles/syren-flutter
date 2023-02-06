import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnosticCenterController extends GetxController {
  // Form.
  final fastingController = TextEditingController();
  final randomController = TextEditingController();

  // Observables.
  var isLoadingSignIn = false.obs;

  @override
  void onClose() {
    fastingController.dispose();
    randomController.dispose();
    super.onClose();
  }
}
