import 'package:get/get.dart';

import 'diagnostic_center_controller.dart';

class DiagnosticCenterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiagnosticCenterController());
  }
}
