import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:syren/controllers/controllers.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class SetVitalReminderController extends GetxController {
  // Services.
  final localNotificationSrv = Get.put(LocalNotificationService());
  final notificationSrv = Get.put(NotificationService());
  final reminderSrv = Get.find<ReminderService>();

  // Controllers.
  final userCtrl = Get.put(UserController());

  // Data.
  var vitals = ['Blood Pressure', 'Blood Sugar'];

  // Form.
  final noteCtrl = TextEditingController();

  // Observables.
  Rxn<String> vitalDropdownValue = Rxn<String>();
  List<Time> morningTimes = const [
    Time(8, 0, 0),
    Time(9, 0, 0),
    Time(10, 0, 0),
    Time(11, 0, 0),
    Time(12, 0, 0)
  ];
  List<Time> nightTimes = const [
    Time(18, 0, 0),
    Time(19, 0, 0),
    Time(20, 0, 0),
    Time(21, 0, 0),
    Time(22, 0, 0)
  ];
  RxList<Time> selectedTimes = <Time>[].obs;

  List<NotificationInterval> intervals = const [
    NotificationInterval.oneOff,
    NotificationInterval.daily,
    NotificationInterval.weekly,
    NotificationInterval.monthly,
    NotificationInterval.yearly
  ];
  Rx<NotificationInterval> selectedInterval = NotificationInterval.oneOff.obs;
  var isloading = false.obs;

  @override
  void onClose() {
    noteCtrl.dispose();

    super.onClose();
  }

  void setSelectedTime(Time time) {
    if (selectedTimes.contains(time)) {
      selectedTimes.remove(time);
    } else {
      selectedTimes.add(time);
    }
  }

  void setSelectedInterval(NotificationInterval interval) {
    selectedInterval.value = interval;
  }

  Future<void> addReminder() async {
    try {
      isloading(true);
      final now = DateTime.now();

      for (var time in selectedTimes) {
        var notification = NotificationModel(
            title: vitalDropdownValue.value,
            body:
                'It’s time to check your ${vitalDropdownValue.value} ${userCtrl.user!.name!.split(' ')[0]}, Always stay on top of your health.',
            note: noteCtrl.text.trim(),
            time: Time(time.hour, time.minute),
            notificationType: NotificationType.vitalReminder,
            date: DateTime(now.year, now.month, now.day, time.hour, time.minute)
                .toString());
        await notificationSrv.insert(notification);

        await reminderSrv.insert(ReminderModel(
            title: notification.title,
            time: notification.time,
            date: notification.date,
            body: notification.body,
            notificationType: notification.notificationType,
            note: notification.note));

        await localNotificationSrv.scheduleNotification(notification);
      }

      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading(false);
    }
  }
}

class SetVitalReminderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetVitalReminderController());
  }
}
