import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syren/screens/schedule_care/clinic_appointment/clinic_appointment_controller.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class ClinicAppointmentView extends GetView<ClinicAppointmentController> {
  const ClinicAppointmentView({super.key});
  static const String routeName = '/clinic-appointment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Clinic Appointment')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: controller.clinicAppointmentFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownSelectField(
                      labelText: 'Select specialty',
                      editingCtrl: controller.specialtyCtrl,
                      options: controller.specialties,
                      onChanged: (String? val) {
                        controller.specialtyCtrl.text = val!;
                        controller.specialtyDropdownValue.value = val;
                      },
                      dropdownValue: controller.specialtyDropdownValue.value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SelectDateField(
                      label: 'Select Appointment Date',
                      selectedDay: controller.selectedDay.value,
                      focusedDay: controller.focusedDay.value,
                      onDaySelected: controller.onDaySelected,
                    ),
                    ..._buildSelectTimeField(),
                    AppTextField(
                      maxLines: 5,
                      labelText:
                          'Give a brief note why you require a specialty',
                      hintText: 'Give a brief note....',
                      editingCtrl: controller.noteCtrl,
                      validationText: 'note.',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Schedule Appointment',
                        disabled: controller.isSavingClinicAppointment.value,
                        loading: controller.isSavingClinicAppointment.value,
                        press: () async {
                          if (controller.clinicAppointmentFormKey.currentState!
                              .validate()) {
                            if (controller.selectedTime.value == '') {
                              UIConfig.showSnackBar(
                                  message:
                                      'Please select a valid time for your appointment',
                                  backgroundColor: Colors.red);
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                              UIConfig.showConfirmBottomSheet(
                                  icon: Icons.alarm,
                                  promptText:
                                      'Are you sure you want to save a clinic appointment\n for ${controller.selectedTime.value} on ${DateFormat('EEEE').format(controller.selectedDay.value)}?',
                                  onConfirmPress: () async {
                                    Get.back();
                                    await controller.saveClinicAppointment();
                                  });
                            }
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ))),
          ),
        ));
  }

  List<Widget> _buildSelectTimeField() {
    return [
      const Text(
        'Select Time',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Palette.secondary),
      ),
      const SizedBox(
        height: 10,
      ),
      const LabelButton(label: 'Morning', icon: Icons.mode_night_outlined),
      const SizedBox(
        height: 10,
      ),
      Wrap(
        children: [
          TimeButton(
            label: '08:00',
            isSelected: controller.selectedTime.value == '08:00',
            onTap: () {
              controller.selectedTime.value = '08:00';
            },
          ),
          TimeButton(
              label: '09:00',
              isSelected: controller.selectedTime.value == '09:00',
              onTap: () {
                controller.selectedTime.value = '09:00';
              }),
          TimeButton(
            label: '10:00',
            isSelected: controller.selectedTime.value == '10:00',
            onTap: () {
              controller.selectedTime.value = '10:00';
            },
          ),
          TimeButton(
              label: '11:00',
              isSelected: controller.selectedTime.value == '11:00',
              onTap: () {
                controller.selectedTime.value = '11:00';
              }),
          TimeButton(
              label: '12:00',
              isSelected: controller.selectedTime.value == '12:00',
              onTap: () {
                controller.selectedTime.value = '12:00';
              }),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      const LabelButton(label: 'Noon', icon: Icons.wb_sunny_outlined),
      const SizedBox(
        height: 16,
      ),
      Wrap(
        children: [
          TimeButton(
            label: '01:00',
            isSelected: controller.selectedTime.value == '01:00',
            onTap: () {
              controller.selectedTime.value = '01:00';
            },
          ),
          TimeButton(
              label: '02:00',
              isSelected: controller.selectedTime.value == '02:00',
              onTap: () {
                controller.selectedTime.value = '02:00';
              }),
          TimeButton(
            label: '03:00',
            isSelected: controller.selectedTime.value == '03:00',
            onTap: () {
              controller.selectedTime.value = '03:00';
            },
          ),
          TimeButton(
              label: '04:00',
              isSelected: controller.selectedTime.value == '04:00',
              onTap: () {
                controller.selectedTime.value = '04:00';
              }),
          TimeButton(
              label: '05:00',
              isSelected: controller.selectedTime.value == '05:00',
              onTap: () {
                controller.selectedTime.value = '05:00';
              }),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
    ];
  }
}
