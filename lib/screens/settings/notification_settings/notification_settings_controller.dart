import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  // Services.
}

class NotificationSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationSettingsController());
  }
}
