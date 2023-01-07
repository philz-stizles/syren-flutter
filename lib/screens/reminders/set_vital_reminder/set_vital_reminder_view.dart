import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';

import 'set_vital_reminder_controller.dart';

class SetVitalReminderView extends GetView<SetVitalReminderController> {
  SetVitalReminderView({super.key});
  static String routeName = "/set-vital-reminder";
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.medical_services),
            SizedBox(
              width: 5,
            ),
            Text('Syren')
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: defaultScreenPadding,
            child: Column(
              children: [],
            )),
      ),
    );
  }
}
