import 'package:get/get.dart';

class RemindersController extends GetxController {
  // Observables.
  var morningMedications = false.obs;
}

class RemindersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindersController());
  }
}
