import 'package:get/get.dart';

class DrugReminderController extends GetxController {
  DrugReminderController();

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  @override
  void onReady() {
    super.onReady();
  }
}
