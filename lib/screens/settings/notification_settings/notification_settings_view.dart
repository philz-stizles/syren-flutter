import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';

import 'notification_settings_controller.dart';

class NotificationSettingsView extends GetView<NotificationSettingsController> {
  const NotificationSettingsView({super.key});
  static const String routeName = '/notification-settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Notification Settings')),
      body: Padding(
        padding: defaultScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'General',
              style: TextStyle(fontSize: 12, color: Palette.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Receive Push  Notifications',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Palette.label),
                ),
                Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        activeColor: Palette.primary,
                        value: true,
                        onChanged: (value) {}))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Notify me when',
              style: TextStyle(fontSize: 12, color: Palette.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Time to take my Medications',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Palette.label),
                ),
                Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        activeColor: Palette.primary,
                        value: true,
                        onChanged: (value) {}))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Time to Check My Vitals',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Palette.label),
                ),
                Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        activeColor: Palette.primary,
                        value: true,
                        onChanged: (value) {}))
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar:
      //     AppBottomNavigationBar(currentIndex: 3, onTap: ((value) {})),
    );
  }
}
