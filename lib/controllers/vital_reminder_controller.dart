import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class VitalReminderController extends GetxController {
  VitalReminderController();

  // Services.
  final vitalReminderSrv = Get.put(VitalReminderService());

  // Observables.
  var vitalReminders = <VitalReminderModel>[].obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;

  @override
  Future<void> onReady() async {
    await getReminders();
    super.onReady();
  }

  Future<VitalReminderModel?> addReminder(
      {VitalReminderModel? reminder}) async {
    return await vitalReminderSrv.insert(reminder);
  }

  Future<void> getReminders() async {
    vitalReminders.assignAll(await vitalReminderSrv.query());
  }
}
