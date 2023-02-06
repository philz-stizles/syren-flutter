import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'ambulance_service_controller.dart';

class AmbulanceServiceView extends GetView<AmbulanceServiceController> {
  AmbulanceServiceView({super.key});
  static const String routeName = '/ambulance-service';

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
            automaticallyImplyLeading: true,
            title: const Text('Ambulance Service')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: controller.ambulanceServiceFormKey,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Pick up',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Palette.label),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.my_location,
                                color: Palette.success,
                              )
                            ]),
                        const SizedBox(
                          height: 5,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(color: Palette.grey),
                              borderRadius:
                                  BorderRadius.circular(secondaryBorderRadius)),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: TextButton.icon(
                                style: const ButtonStyle(),
                                onPressed: () {
                                  controller.navigateToMapScreen(context);
                                },
                                icon: const Icon(Icons.my_location,
                                    color: Palette.success),
                                label: const Text(
                                  'Select on Map',
                                  style: TextStyle(color: Palette.grey),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Drop off',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Palette.label),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.location_on_outlined,
                                color: Palette.primary,
                              )
                            ]),
                        const SizedBox(
                          height: 5,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(color: Palette.grey),
                              borderRadius:
                                  BorderRadius.circular(secondaryBorderRadius)),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: TextButton.icon(
                                style: const ButtonStyle(),
                                onPressed: () {
                                  controller.navigateToMapScreen(context);
                                },
                                icon: const Icon(Icons.location_on_outlined,
                                    color: Palette.primary),
                                label: const Text(
                                  'Select on Map',
                                  style: TextStyle(color: Palette.grey),
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      maxLines: 3,
                      labelText: 'Any special request?',
                      hintText: 'State any special request if any',
                      editingCtrl: controller.samplesCtrl,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: RichText(
                          text: const TextSpan(
                              text: 'Bill estimate: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Palette.label,
                                  fontWeight: FontWeight.w600),
                              children: [
                            TextSpan(
                              text: 'N10,000',
                              style:
                                  TextStyle(fontSize: 24, color: Palette.label),
                            )
                          ])),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Confirm Request',
                        disabled: controller.isSavingAmbulanceService.value,
                        loading: controller.isSavingAmbulanceService.value,
                        press: () async {
                          if (controller.ambulanceServiceFormKey.currentState!
                              .validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.alarm,
                                promptText:
                                    'Are you sure you want to schedule\n this home visit?',
                                onConfirmPress: () async {
                                  Get.back();
                                  await controller.saveAmbulanceService();
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
