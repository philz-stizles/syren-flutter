import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/change_password/change_password_view.dart';
import 'package:syren/screens/settings/feedback/feedback_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/navigation_bar.dart';
import 'package:syren/widgets/widgets.dart';

import 'settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text('Settings')),
      body: Padding(
        padding: defaultScreenPadding,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            AppMenuItem(
              icon: Icons.notifications_outlined,
              label: 'Notifications settings',
              onTap: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            AppMenuItem(
              icon: Icons.key_outlined,
              label: 'Password and security',
              onTap: () => Get.toNamed(ChangePasswordView.routeName),
            ),
            const SizedBox(
              height: 15,
            ),
            AppMenuItem(
              icon: Icons.info_outline,
              label: 'Feedback',
              onTap: () => Get.toNamed(FeedbackView.routeName),
            ),
            const SizedBox(
              height: 15,
            ),
            AppMenuItem(
              icon: Icons.delete_outlined,
              onTap: () {},
              label: 'Delete account',
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          AppBottomNavigationBar(currentIndex: 3, onTap: ((value) {})),
    );
  }
}
