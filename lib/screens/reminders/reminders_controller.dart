import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class RemindersController extends GetxController {
  // Services.
  final notificationSrv = Get.find<NotificationService>();

  // Observables.
  var page = 0.obs;
  var morningMedications = true.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  Future<void> onReady() async {
    debugPrint('ready reminders');
    await getNotifications();
    super.onReady();
  }

  Future<void> getNotifications() async {
    notifications.assignAll(await notificationSrv.query());
  }
}

class RemindersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindersController());
  }
}
