import 'package:get/get.dart';

import 'clinic_appointment_controller.dart';

class ClinicAppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClinicAppointmentController());
  }
}