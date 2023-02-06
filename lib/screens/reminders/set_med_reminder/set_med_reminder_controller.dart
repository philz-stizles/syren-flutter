import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:syren/controllers/controllers.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/dashboard/dashboard_controller.dart';
import 'package:syren/services/services.dart';

class SetMedReminderController extends GetxController {
  // Services.
  final localNotificationSrv = Get.put(LocalNotificationService());
  final notificationSrv = Get.put(NotificationService());
  final reminderSrv = Get.find<ReminderService>();

  // Controllers.
  final userCtrl = Get.put(UserController());
  final dashboardCtrl = Get.put(DashboardController());

  // Data.
  var drugTypes = ['Tablets', 'Syrup'];

  // Form.
  final nameCtrl = TextEditingController();

  // Observables.
  RxBool isLoadingSetReminder = false.obs;
  Rxn<String> drugTypeDropdownValue = Rxn<String>();
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
    Time(23, 15, 0)
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

  @override
  void onClose() {
    nameCtrl.dispose();

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
      isLoadingSetReminder(true);
      final now = DateTime.now();

      for (var time in selectedTimes) {
        var notification = NotificationModel(
            title: 'Medication',
            body:
                'It’s time to check your medication ${userCtrl.user!.name!.split(' ')[0]}, Always stay on top of your health.',
            note: '${nameCtrl.text.trim()} ${drugTypeDropdownValue.value}',
            time: Time(time.hour, time.minute),
            notificationType: NotificationType.medReminder,
            date: DateTime(now.year, now.month, now.day, time.hour, time.minute)
                .toString());

        // Save notification.
        // await notificationSrv.insert(notification);

        // Save reminder.
        await reminderSrv.insert(ReminderModel(
            title: notification.title,
            time: notification.time,
            date: notification.date,
            body: notification.body,
            notificationType: notification.notificationType,
            note: notification.note));

        // Schedule reminder notification.
        await localNotificationSrv.scheduleNotification(notification);
      }
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingSetReminder(false);
    }
  }
}

class SetMedReminderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetMedReminderController());
  }
}
