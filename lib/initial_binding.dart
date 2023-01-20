import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    injectService();
  }

  void injectService() async {}
}
