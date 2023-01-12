import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/controllers/vital_reminder_controller.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class SetVitalReminderController extends GetxController {
  // Services.
  final notificationSrv = Get.put(NotificationService());

  // Controllers.
  final vitalReminderCtrl = Get.put(VitalReminderController());

  // Form.
  final vitalReminderFormKey = GlobalKey<FormState>();
  final vitalCtrl = TextEditingController();
  final timeCtrl = TextEditingController();

  // Observables.
  Rx<TimeOfDay> morningTime = const TimeOfDay(hour: 08, minute: 45).obs;
  Rx<TimeOfDay> nightTime = const TimeOfDay(hour: 09, minute: 25).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    vitalCtrl.dispose();
    timeCtrl.dispose();

    super.onClose();
  }

  Future addReminder(hr, min) async {
    final now = DateTime.now();
    await vitalReminderCtrl.addReminder(
        reminder: VitalReminderModel(
            title: vitalCtrl.text.trim(),
            note: 'Take Test',
            date: DateTime(now.year, now.month, now.day, hr, min).toString()));

    // await notificationSrv.scheduleNotifications(
    //     id: 100, title: vitalCtrl.text.trim(), body: 'Body'
    //     // time: DateTime(
    //     //   now.year, now.month, now.day, nightTime.hour, nightTime.minute)
    //     );
  }
}

class SetVitalReminderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetVitalReminderController());
  }
}
