import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  @override
  void onReady() {
    debugPrint('ready settings');
    super.onReady();
  }
}

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
