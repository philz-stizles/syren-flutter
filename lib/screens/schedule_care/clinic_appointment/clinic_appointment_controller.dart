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
  var firestoreSrv = Get.put(FirestoreService<ClinicAppointmentModel>(
    'ClinicAppointments',
    fromDS: (p0, p1) => ClinicAppointmentModel.fromJson(p1!),
    toMap: (model) => model.toJson(),
  ));

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

  final samplesCtrl = TextEditingController();

  // Observables.
  var isSavingClinicAppointment = false.obs;
  Rxn<String> specialtyDropdownValue = Rxn<String>();
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxString selectedTime = ''.obs;

  @override
  void onClose() {
    appointmentDateCtrl.dispose();
    noteCtrl.dispose();
    samplesCtrl.dispose();

    super.onClose();
  }

  void onDaySelected(currentSelectedDay, currentFocusedDay) {
    selectedDay.value = currentSelectedDay;
    focusedDay.value = currentFocusedDay; // update `_focusedDay` here as well
  }

  void clearForm() {
    specialtyDropdownValue.value = null;
    noteCtrl.text == '';
    samplesCtrl.text == '';
    selectedTime.value == '';
  }

  Future<void> saveClinicAppointment() async {
    try {
      isSavingClinicAppointment(true);
      await firestoreSrv.createByUser(ClinicAppointmentModel(
          specialty: specialtyDropdownValue.value,
          note: noteCtrl.text.trim(),
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
