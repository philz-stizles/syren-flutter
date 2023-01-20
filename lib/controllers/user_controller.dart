import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class UserController extends GetxController {
  // Services.
  var userService = Get.put(UserService());

  // Observables.
  Rx<UserModel?> userModel = UserModel().obs;

  UserModel? get user => userModel.value;

  set user(UserModel? value) => userModel.value = value;

  void clear() {
    userModel.value = UserModel();
  }

  @override
  void onReady() async {
    // user = (await userService.getUser())!;
    userModel.bindStream(userService.getUserStream());
  }
}
