import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  static String routeName = "/notifications";
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
                        onPress: () {},
                      )
                    ],
                  ),
                  // const SizedBox(height: 5),
                  Expanded(
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            // var reminder = vitalReminders[index];
                            return NotificationCard(
                                title: 'Medications',
                                message:
                                    'It’s time to take your medications seun, Always stay on top of your health',
                                isRead: false,
                                time: DateTime.now().toString());
                          })))
                ],
              ))),
      bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: 0,
          onTap: ((value) {
            // Get.to(SettingsView());
          })),
    );
  }
}
