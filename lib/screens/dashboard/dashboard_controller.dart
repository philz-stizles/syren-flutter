import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/views.dart';

class DashboardController extends GetxController {
  int? pageIndex;
  RxInt index = 0.obs;

  final List<Widget> screens = <Widget>[
    HomeView(),
    MedicationsView(),
    const RemindersView(),
    SettingsView()
  ];

  final pageController = PageController(initialPage: 0);

  void onTap(int value) {
    FocusManager.instance.primaryFocus!.unfocus();
    index.value = value;
  }
}
