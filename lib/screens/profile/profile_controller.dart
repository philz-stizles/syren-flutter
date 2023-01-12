import 'package:get/get.dart';
import 'package:syren/controllers/user_controller.dart';
import 'package:syren/screens/signin/signin_view.dart';
import 'package:syren/services/services.dart';

class ProfileController extends GetxController {
  // Services.
  var authService = Get.put(AuthService());
  var userService = Get.put(UserService());

  // Services.
  var userCtrl = Get.put(UserController());

  // Observables
  var isProfileSelected = true.obs;

  @override
  Future<void> onInit() async {
    userCtrl.user = await userService.getUser();
    super.onInit();
  }

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
