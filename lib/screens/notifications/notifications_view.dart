import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  static const String routeName = "/notifications";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('Notifications')),
      body: Padding(
          padding: defaultScreenPadding,
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: PrimaryButton(
                        outlined: controller.page.value != 0,
                        title: 'Recent',
                        press: () {
                          controller.page.value = 0;
                        },
                        expanded: false,
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: PrimaryButton(
                        title: 'Older',
                        outlined: controller.page.value != 1,
                        press: () {
                          controller.page.value = 1;
                        },
                        expanded: false,
                      ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextIconButton(
                        label: 'Mark all as read',
                        trailingIcon: Icons.check,
                        onPress: () => controller.markAllAsRead(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextIconButton(
                        label: 'Clear all',
                        trailingIcon: Icons.clear,
                        onPress: () => controller.clearAll(),
                      )
                    ],
                  ),
                  // const SizedBox(height: 5),
                  // ..._buildRecentNotifications(controller.notifications)
                  ..._buildRecentNotifications(controller.notifications)
                ],
              ))),
    );
  }

  List<Widget> _buildRecentNotifications(
      List<NotificationModel> notifications) {
    return [
      Expanded(
          child: ListView.builder(
              itemCount: notifications.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                var notification = notifications[index];
                return NotificationCard(
                    title: notification.title,
                    message: notification.body,
                    isRead: notification.isRead,
                    time: notification.date,
                    icon: notification.notificationType ==
                            NotificationType.vitalReminder
                        ? Icons.bloodtype
                        : Icons.medication);
              })))
    ];
  }
}
