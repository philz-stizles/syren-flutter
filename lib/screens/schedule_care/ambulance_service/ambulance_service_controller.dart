import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/schedule_care/ambulance_service/map_view.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/services/location_service.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class AmbulanceServiceController extends GetxController {
  // Services.
  var firestoreSrv = Get.put(FirestoreService<AmbulanceServiceModel>(
    'AmbulanceServices',
    fromDS: (p0, p1) => AmbulanceServiceModel.fromJson(p1!),
    toMap: (model) => model.toJson(),
  ));

  // Form.
  final ambulanceServiceFormKey = GlobalKey<FormState>();

  final addressCtrl = TextEditingController();
  final specialtyCtrl = TextEditingController();
  final samplesCtrl = TextEditingController();

  // Observables.
  var isSavingAmbulanceService = false.obs;
  Rxn<String> specialtyDropdownValue = Rxn<String>();
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxString selectedTime = ''.obs;
  RxString locationPreviewImageUrl = ''.obs;
  Rx<PlaceLocationModel> pickedLocation =
      const PlaceLocationModel(latitude: 0, longitude: 0).obs;

  @override
  void onClose() {
    addressCtrl.dispose();
    specialtyCtrl.dispose();
    samplesCtrl.dispose();

    super.onClose();
  }

  void onDaySelected(currentSelectedDay, currentFocusedDay) {
    selectedDay.value = currentSelectedDay;
    focusedDay.value = currentFocusedDay; // update `_focusedDay` here as well
  }

  void clearForm() {
    specialtyCtrl.clear();
    addressCtrl.clear();
    samplesCtrl.clear();
    selectedTime.value = '';
  }

  Future<void> saveAmbulanceService() async {
    try {
      isSavingAmbulanceService(true);
      await firestoreSrv.createByUser(AmbulanceServiceModel(
          specialty: specialtyCtrl.text,
          address: addressCtrl.text.trim(),
          samples: samplesCtrl.text.trim(),
          date: selectedDay.value,
          time: selectedTime.value));

      clearForm();

      Get.to(const SuccessView(
        message: 'Your Appointment has been Scheduled successfully',
        title: 'Ambulance Service',
        backToPage: ScheduleCareView.routeName,
      ));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isSavingAmbulanceService(false);
    }
  }

  void showPreview(double? latitude, double? longitude) async {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: latitude, longitude: longitude);

    locationPreviewImageUrl.value = staticMapImageUrl;
  }

  Future<void> getCurrentUserLocation() async {
    try {
      final locationData = await Location().getLocation();

      showPreview(locationData.latitude, locationData.longitude);

      selectLocation(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      return;
    }
  }

  Future<void> navigateToMapScreen(BuildContext context) async {
    final locationData = await Location().getLocation();
    final LatLng? selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                  initialLocation: PlaceLocationModel(
                      latitude: locationData.latitude!,
                      longitude: locationData.longitude!),
                )));

    if (selectedLocation == null) {
      return;
    }

    showPreview(selectedLocation.latitude, selectedLocation.longitude);

    selectLocation(selectedLocation.latitude, selectedLocation.longitude);
  }

  void selectLocation(double latitude, double longitude) {
    pickedLocation.value =
        PlaceLocationModel(latitude: latitude, longitude: longitude);
  }
}

class AmbulanceServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AmbulanceServiceController());
  }
}
