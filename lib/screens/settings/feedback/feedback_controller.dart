import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/services/services.dart';

class FeedbackController extends GetxController {
  // Services.
  var authService = Get.put(AuthService());

  // Data.
  var feedbackCategories = [
    'Medications',
    'Medication equipments',
    'Urgent care',
    'Ambulance service',
    'The app in general'
  ];

  // Form.
  final currentCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  // Observables.
  var isLoadingFeedback = false.obs;

  @override
  void onClose() {
    currentCtrl.dispose();
    newCtrl.dispose();
    confirmCtrl.dispose();
    super.onClose();
  }
}

class FeedbackBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbackController());
  }
}
