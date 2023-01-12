import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syren/services/services.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    injectService();
  }

  void injectService() async {
    await GetStorage.init();
    await Get.putAsync(() => EnvironmentService().init());
    await Get.putAsync(() => DeviceService().init());
    await Get.putAsync(() => AppService().init());
    // await Get.putAsync(() => ThemeService().init());
    await Get.putAsync(() => BiometricService().init());
    await Get.putAsync(() => EmailService().init());
    await Get.putAsync(() => NotificationService().init());
    await Get.putAsync(() => VitalReminderService().init());
  }
}
