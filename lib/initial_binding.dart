import 'package:get/get.dart';
import 'package:syren/screens/signin/signin_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}