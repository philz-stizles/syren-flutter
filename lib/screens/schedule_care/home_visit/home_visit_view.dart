import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'home_visit_controller.dart';

class HomeVisitView extends GetView<HomeVisitController> {
  const HomeVisitView({super.key});
  static const String routeName = '/home-visit';

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
        height: 20,
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true, title: const Text('Home Visit')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: controller.homeVisitFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SelectDateField(
                      label: 'Select Appointment Date',
                      selectedDay: controller.selectedDay.value,
                      focusedDay: controller.focusedDay.value,
                      onDaySelected: controller.onDaySelected,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ..._buildSelectTimeField(),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      labelText: 'Type in your address',
                      hintText: 'Enter your address',
                      editingCtrl: controller.addressCtrl,
                    ),
                    DropdownSelectField(
                      labelText: 'Select specialty',
                      options: controller.specialties,
                      onChanged: (String? val) {
                        controller.specialtyDropdownValue.value = val;
                      },
                      dropdownValue: controller.specialtyDropdownValue.value,
                    ),
                    AppTextField(
                      labelText: 'Specify samples to be collected',
                      hintText: 'Specify samples',
                      editingCtrl: controller.samplesCtrl,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Confirm Home Visit',
                        disabled: controller.isSavingHomeVisit.value,
                        loading: controller.isSavingHomeVisit.value,
                        press: () async {
                          if (controller.homeVisitFormKey.currentState!
                              .validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.alarm,
                                promptText:
                                    'Are you sure you want to schedule\n this home visit?',
                                onConfirmPress: () async {
                                  Get.back();
                                  await controller.saveHomeVisit();
                                });
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
}
