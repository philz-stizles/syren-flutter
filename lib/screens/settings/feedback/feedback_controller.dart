import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/settings/settings_view.dart';
import 'package:syren/screens/success.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class FeedbackController extends GetxController {
  // Services.
  var feedbackSrv = Get.put(FeedbackService());

  // Data.
  var feedbackCategories = [
    'Medications',
    'Medication equipments',
    'Urgent care',
    'Ambulance service',
    'The app in general'
  ];

  // Form.
  final messageCtrl = TextEditingController();

  // Observables.
  RxBool isSavingFeedback = false.obs;
  RxDouble rating = 0.0.obs;
  final category = Rxn<String>();

  @override
  void onClose() {
    messageCtrl.dispose();

    super.onClose();
  }

  void clearForm() {
    rating.value = 0.0;
    category.value = null;
    messageCtrl.clear();
  }

  Future<void> saveFeedback() async {
    try {
      isSavingFeedback(true);
      await feedbackSrv.create(FeedbackModel(
        category: category.value,
        message: messageCtrl.text.trim(),
        rating: rating.value,
        date: DateTime.now(),
      ));

      clearForm();

      FocusManager.instance.primaryFocus?.unfocus();

      Get.to(SuccessView(
        message: 'You\'ve successfully submitted your feedback',
        title: 'Feedback',
        backToPage: SettingsView.routeName,
      ));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isSavingFeedback(false);
    }
  }
}

class FeedbackBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbackController());
  }
}
