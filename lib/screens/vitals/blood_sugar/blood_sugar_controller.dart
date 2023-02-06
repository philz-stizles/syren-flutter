import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class BloodSugarController extends GetxController {
  // Services.
  var firestoreSrv = Get.put(FirestoreService<BloodSugarModel>('bloodSugars',
      fromDS: (p0, p1) => BloodSugarModel.fromJson(p1!)));

  // Observables.
  var page = 1.obs;
  Rx<List<BloodSugarModel>> bpList = Rx<List<BloodSugarModel>>([]);
  List<BloodSugarModel> get bps => bpList.value;
  var isLoadingSaveBp = false.obs;

  @override
  void onReady() {
    bpList.bindStream(firestoreSrv.streamQueryListByUser(
        orderBy: [OrderBy('timeStamp', descending: true)]));
  }
}

class BloodSugarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BloodSugarController());
  }
}
