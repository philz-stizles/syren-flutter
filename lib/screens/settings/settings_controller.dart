import 'package:get/get.dart';

class SettingsController extends GetxController {}

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
