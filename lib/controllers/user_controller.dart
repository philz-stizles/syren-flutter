import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class UserController extends GetxController {
  // final MyRepository repository;
  UserController();

  // Observables.
  Rx<UserModel> user = UserModel().obs;
}
