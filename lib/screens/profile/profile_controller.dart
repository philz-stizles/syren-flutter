import 'package:get/get.dart';
import 'package:syren/screens/signin/signin_view.dart';
import 'package:syren/services/auth_service.dart';

class ProfileController extends GetxController {
  var authService = Get.put(AuthService());

  Future<void> signOut() async {
    await authService.signOut();
    Get.back();
    Get.toNamed(SignInView.routeName);
  }
}

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
