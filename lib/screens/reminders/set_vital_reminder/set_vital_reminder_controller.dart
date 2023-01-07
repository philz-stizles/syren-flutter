import 'package:get/get.dart';

class SetVitalReminderController extends GetxController {}

class SetVitalReminderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetVitalReminderController());
  }
}
