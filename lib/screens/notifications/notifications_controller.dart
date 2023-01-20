import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class NotificationsController extends GetxController {
  // Services.
  final notificationSrv = Get.find<NotificationService>();

  // Observables.
  RxInt page = 0.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  Future<void> onReady() async {
    await getNotifications();
    super.onReady();
  }

  Future<void> getNotifications() async {
    notifications.assignAll(await notificationSrv.query());
  }

  Future<void> markAsRead(int id) async {
    var affectedRecord = await notificationSrv.markAsRead(id);
    if (affectedRecord > 0) {
      await getNotifications();
    }
  }

  Future<void> markAllAsRead() async {
    var affectedRecords = await notificationSrv.markAllAsRead();
    if (affectedRecords > 0) {
      await getNotifications();
    }
  }

  Future<void> clear(int id) async {
    var affectedRecords = await notificationSrv.delete(id);
    if (affectedRecords > 0) {
      await getNotifications();
    }
  }

  Future<void> clearAll() async {
    var affectedRecords = await notificationSrv.deleteAll();
    if (affectedRecords > 0) {
      await getNotifications();
    }
  }
}

class NotificationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
  }
}
