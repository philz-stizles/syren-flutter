import 'package:get/get.dart';
import 'package:syren/models/notification_model.dart';
import 'package:syren/services/services.dart';

class RemindersController extends GetxController {
  // Services.
  final reminderSrv = Get.find<ReminderService>();

  // Observables.
  RxInt page = 0.obs;
  RxBool morningMedications = true.obs;
  RxBool eveningMedications = true.obs;

  Future<void> clearAll() async {
    await reminderSrv.clearAll();
  }

  Future<void> clear(NotificationType type) async {
    await reminderSrv.clearByType(type);
  }
}

class RemindersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindersController());
  }
}
