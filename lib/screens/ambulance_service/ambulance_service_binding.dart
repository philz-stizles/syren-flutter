import 'package:get/get.dart';

import 'ambulance_service_controller.dart';

class AmbulanceServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AmbulanceServiceController());
  }
}