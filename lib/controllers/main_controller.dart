import 'package:get/get.dart';
import 'package:syren/models/models.dart';

class MainController extends GetxController {
  Rx<UserModel?> currentUser = UserModel().obs;
}
