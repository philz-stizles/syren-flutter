import 'package:flutter/material.dart';
import 'package:syren/utils/palette.dart';

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
    return DecoratedBox(
        decoration: const BoxDecoration(
          color: Palette.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              // spreadRadius: 10.0,
              blurRadius: 4.0,
              offset: Offset(0, -4),
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: BottomNavigationBar(
              onTap: onTap,
              // onTap: (int value) {
              //   if (value == 0) {
              //     Get.to(DashboardScreen());
              //   } else if (value == 1) {
              //     Get.toNamed(MedicationsView.routeName);
              //   } else if (value == 2) {
              //     Get.toNamed(RemindersView.routeName);
              //   } else {
              //     Get.toNamed(SettingsView.routeName);
              //   }
              // },
              currentIndex: currentIndex,
              unselectedFontSize: 11,
              selectedFontSize: 11,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.medication_outlined),
                    label: 'Medications'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.alarm_outlined), label: 'Reminders'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined), label: 'Settings'),
              ],
            )));
  }
}
