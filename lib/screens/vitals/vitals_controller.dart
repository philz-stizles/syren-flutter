import 'package:get/get.dart';

class VitalsController extends GetxController {}

class VitalsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VitalsController());
  }
}
