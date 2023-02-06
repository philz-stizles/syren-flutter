import 'package:get/get.dart';
import 'package:syren/models/models.dart';

import 'package:syren/services/services.dart';

class MedicationsController extends GetxController {
  // Providers.
  var firestoreSrv = Get.put(FirestoreService<MedicationModel>(
    'Medications',
    fromDS: (p0, p1) => MedicationModel.fromJson(p1!),
    toMap: (model) => model.toJson(),
  ));

  // Observables.
  Rx<List<MedicationModel>> medList = Rx<List<MedicationModel>>([]);
  List<MedicationModel> get meds => medList.value;
  var isLoadingMedications = false.obs;
  var selectedPageIndex = 0.obs;

  // @override
  // Future<void> onInit() async {
  //   await loadMedications();
  //   super.onInit();
  // }

  @override
  void onReady() {
    medList.bindStream(firestoreSrv.streamListByUser());
    super.onReady();
  }

  // Future<void> loadMedications() async {
  //   try {
  //     isLoadingMedications(true);
  //     await firestoreSrv.getQueryList();
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint(e.message);
  //     if (e.message != null) {
  //       UIConfig.showSnackBar(
  //           message: e.message as String, backgroundColor: Colors.red);
  //     }
  //   } finally {
  //     isLoadingMedications(false);
  //   }
  // }
}

class MedicationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MedicationsController());
  }
}
