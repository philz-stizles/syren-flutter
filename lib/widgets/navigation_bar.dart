import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/dashboard/dashboard.dart';
import 'package:syren/screens/medications/medications_view.dart';
import 'package:syren/screens/reminders/reminders_view.dart';
import 'package:syren/screens/settings/settings_view.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int value) {
        if (value == 0) {
          Get.to(DashboardScreen());
        } else if (value == 1) {
          Get.to(MedicationsView());
        } else if (value == 2) {
          Get.toNamed(RemindersView.routeName);
        } else {
          Get.to(SettingsView());
        }
      },
      currentIndex: currentIndex,
      unselectedFontSize: 11,
      selectedFontSize: 11,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.medication_outlined), label: 'Medications'),
        BottomNavigationBarItem(
            icon: Icon(Icons.alarm_outlined), label: 'Reminders'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), label: 'Settings'),
      ],
    );
  }
}
