import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/medications/medications_controller.dart';
import 'package:syren/screens/reminders/reminders_controller.dart';

import 'package:syren/screens/views.dart';

class DashboardController extends GetxController {
  // Controllers.
  var m = Get.put(MedicationsController());
  var r = Get.put(RemindersController());

  final List<Widget> screens = <Widget>[
    HomeView(),
    MedicationsView(),
    RemindersView(),
    const SettingsView()
  ];

  RxInt index = 0.obs;

  void onTap(int value) {
    // FocusManager.instance.primaryFocus!.unfocus();
    index.value = value;
  }
}

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
