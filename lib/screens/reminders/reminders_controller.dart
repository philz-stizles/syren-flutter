import 'package:get/get.dart';
import 'package:syren/controllers/vital_reminder_controller.dart';

class RemindersController extends GetxController {
  // Controllers.
  final vitalReminderCtrl = Get.put(VitalReminderController());

  // Observables.
  var morningMedications = false.obs;
  var page = 0.obs;
}

class RemindersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindersController());
  }
}
