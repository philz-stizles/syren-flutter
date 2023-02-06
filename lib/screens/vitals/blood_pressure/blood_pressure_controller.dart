import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class BloodPressureController extends GetxController {
  // Services.
  var firestoreService = Get.put(FirestoreService<BloodPressureModel>(
      'bloodPressures',
      fromDS: (p0, p1) => BloodPressureModel.fromJson(p1!)));

  // Observables.
  var page = 1.obs;
  Rx<List<BloodPressureModel>> bpList = Rx<List<BloodPressureModel>>([]);
  List<BloodPressureModel> get bps => bpList.value;
  var isLoadingSaveBp = false.obs;

  @override
  void onReady() {
    bpList.bindStream(firestoreService.streamQueryListByUser(
        orderBy: [OrderBy('timeStamp', descending: true)]));
  }
}

class BloodPressureBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BloodPressureController());
  }
}
