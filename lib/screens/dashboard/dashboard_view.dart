import 'package:flutter/material.dart';
import 'package:syren/screens/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class DashboardScreen extends GetView<DashboardController> {
  DashboardScreen({super.key});

  static const String routeName = "/dashboard";

  final dashboardCtrl = Get.put(DashboardController());

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
