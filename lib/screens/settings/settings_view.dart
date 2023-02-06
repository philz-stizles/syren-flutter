import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  static const String routeName = '/settings';

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
              onTap: () => Get.toNamed(NotificationSettingsView.routeName),
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
              onTap: () => Get.to(DeleteAccountView()),
              label: 'Delete account',
            ),
          ],
        ),
      ),
    );
  }
}
