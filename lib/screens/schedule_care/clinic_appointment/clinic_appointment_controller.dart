import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/schedule_care/schedule_care_view.dart';
import 'package:syren/screens/success.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class ClinicAppointmentController extends GetxController {
  // Services.
  var clinicAppointmentSrv = Get.put(ClinicAppointmentService());

  // Data.
  var specialties = [
    'Orthopedics',
    'Cardiology',
    'Gynacology',
    'Pediatrics',
    'Therapist'
  ];

  // Form.
  final clinicAppointmentFormKey = GlobalKey<FormState>();
  final appointmentDateCtrl = TextEditingController();

  final noteCtrl = TextEditingController();
  final specialtyCtrl = TextEditingController();
  final samplesCtrl = TextEditingController();

  // Observables.
  var isSavingClinicAppointment = false.obs;
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
    noteCtrl.dispose();
    specialtyCtrl.dispose();
    samplesCtrl.dispose();

    super.onClose();
  }

  void onDaySelected(currentSelectedDay, currentFocusedDay) {
    selectedDay.value = currentSelectedDay;
    focusedDay.value = currentFocusedDay; // update `_focusedDay` here as well
  }

  void clearForm() {
    specialtyCtrl.text == '';
    noteCtrl.text == '';
    samplesCtrl.text == '';
    selectedTime.value == '';
  }

  Future<void> saveClinicAppointment() async {
    try {
      isSavingClinicAppointment(true);
      await clinicAppointmentSrv.createByUser(ClinicAppointmentModel(
          specialty: specialtyCtrl.text,
          note: noteCtrl.text.trim(),
          date: selectedDay.value,
          time: selectedTime.value));

      clearForm();

      Get.to(SuccessView(
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
      isSavingClinicAppointment(false);
    }
  }
}

class ClinicAppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClinicAppointmentController());
  }
}
