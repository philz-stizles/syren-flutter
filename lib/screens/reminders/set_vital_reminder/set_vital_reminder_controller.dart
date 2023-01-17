import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:syren/controllers/vital_reminder_controller.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/views.dart';
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
  var isloading = false.obs;

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

  Future addReminder(TimeOfDay time) async {
    isloading(true);
    final now = DateTime.now();
    await vitalReminderCtrl.addReminder(
        reminder: VitalReminderModel(
            title: vitalCtrl.text.trim(),
            note: 'Take Test',
            date: DateTime(now.year, now.month, now.day, time.hour, time.minute)
                .toString()));

    await notificationSrv.scheduleNotification(
        id: 0,
        title: vitalCtrl.text.trim(),
        body: 'Body',
        time: Time(time.hour, time.minute));
    isloading(true);
    Get.toNamed(RemindersView.routeName);
  }
}

class SetVitalReminderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetVitalReminderController());
  }
}
