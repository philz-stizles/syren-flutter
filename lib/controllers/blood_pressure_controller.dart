import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class BloodPressureController extends GetxController {
  // Services.
  var bPService = Get.put(BloodPressureService());

  // Observables.
  Rx<List<BloodPressureModel>> bpList = Rx<List<BloodPressureModel>>([]);
  List<BloodPressureModel> get bps => bpList.value;

  @override
  void onReady() {
    bpList.bindStream(bPService.stream());
  }
}
