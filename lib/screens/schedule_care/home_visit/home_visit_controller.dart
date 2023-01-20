import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/schedule_care/schedule_care_view.dart';
import 'package:syren/screens/success.dart';
import 'package:syren/services/home_visit_service.dart';
import 'package:syren/widgets/widgets.dart';

class HomeVisitController extends GetxController {
  // Services.
  var homeVisitSrv = Get.put(HomeVisitService());

  // Data.
  var specialties = [
    'Orthopedics',
    'Cardiology',
    'Gynacology',
    'Pediatrics',
    'Therapist'
  ];

  // Form.
  final homeVisitFormKey = GlobalKey<FormState>();
  final appointmentDateCtrl = TextEditingController();

  final addressCtrl = TextEditingController();
  final specialtyCtrl = TextEditingController();
  final samplesCtrl = TextEditingController();

  // Observables.
  var isSavingHomeVisit = false.obs;
  var specialtyDropdownValue = ''.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxString selectedTime = ''.obs;

  @override
  void onInit() {
    specialtyDropdownValue.value = specialties[0];
    specialtyCtrl.text = specialties[0];

    super.onInit();
  }

  @override
  void onClose() {
    appointmentDateCtrl.dispose();
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

  Future<void> saveHomeVisit() async {
    try {
      isSavingHomeVisit(true);
      await homeVisitSrv.createByUser(HomeVisitModel(
          specialty: specialtyCtrl.text,
          address: addressCtrl.text.trim(),
          samples: samplesCtrl.text.trim(),
          date: selectedDay.value,
          time: selectedTime.value));

      clearForm();

      Get.to(const SuccessView(
        message: 'Your Appointment has been Scheduled successfully',
        title: 'Home Visit',
        backToPage: ScheduleCareView.routeName,
      ));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isSavingHomeVisit(false);
    }
  }
}

class HomeVisitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeVisitController());
  }
}
