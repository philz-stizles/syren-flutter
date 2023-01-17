import 'package:get/get.dart';

class NotificationsController extends GetxController {
  // Observables.
  var page = 0.obs;
}

class NotificationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
  }
}
