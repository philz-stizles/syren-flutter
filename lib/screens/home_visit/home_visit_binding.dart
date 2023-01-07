import 'package:get/get.dart';

import 'home_visit_controller.dart';

class HomeVisitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeVisitController());
  }
}