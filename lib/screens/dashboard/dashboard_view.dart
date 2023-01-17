import 'package:flutter/material.dart';
import 'package:syren/screens/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:syren/screens/medications/medications_controller.dart';
import 'package:syren/screens/reminders/reminders_controller.dart';

import '../../widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final dashboardCtrl = Get.put(DashboardController());
  var m = Get.put(MedicationsController());
  var r = Get.put(RemindersController());

  @override
  Widget build(BuildContext context) {
    return Obx((() => Scaffold(
          body: IndexedStack(
            index: dashboardCtrl.index.value,
            children: dashboardCtrl.screens,
          ),
          bottomNavigationBar: AppBottomNavigationBar(
              currentIndex: dashboardCtrl.index.value,
              onTap: dashboardCtrl.onTap),
        )));
  }
}
