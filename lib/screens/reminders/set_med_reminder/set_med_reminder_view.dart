import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'set_med_reminder_controller.dart';

class SetMedReminderView extends GetView<SetMedReminderController> {
  SetMedReminderView({super.key});
  static const String routeName = "/set-med-reminder";

  final medReminderFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.dimWhite,
        appBar: AppBar(
            automaticallyImplyLeading: true, title: const Text('Set Reminder')),
        body: Obx(() => SingleChildScrollView(
              child: Padding(
                  padding: defaultScreenPadding,
                  child: Form(
                      key: medReminderFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            labelText: 'Drug Name',
                            hintText: 'Enter the drug name',
                            editingCtrl: controller.nameCtrl,
                          ),
                          DropdownSelectField(
                            labelText: 'Type of drug',
                            options: controller.drugTypes,
                            onChanged: (String? val) {
                              controller.drugTypeDropdownValue.value = val;
                            },
                            dropdownValue:
                                controller.drugTypeDropdownValue.value,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ..._buildSelectTimeField(),
                          const SizedBox(
                            height: 10,
                          ),
                          ..._buildReminderInterval(),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Note: This is to remind you to take your medications daily. Always stay healthy.',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Palette.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          PrimaryButton(
                              title: 'Set Reminder',
                              press: () async {
                                if (medReminderFormKey.currentState!
                                    .validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  UIConfig.showConfirmBottomSheet(
                                      icon: Icons.alarm,
                                      promptText:
                                          'Are you sure you want to save\n this reminder?',
                                      onConfirmPress: () async {
                                        Get.back();
                                        await controller.addReminder();
                                      });
                                }
                              })
                        ],
                      ))),
            )));
  }

  List<Widget> _buildSelectTimeField() {
    return [
      const Text(
        'Specific Time',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Palette.secondary),
      ),
      const SizedBox(
        height: 10,
      ),
      const LabelButton(label: 'Morning', icon: Icons.wb_cloudy_outlined),
      const SizedBox(
        height: 16,
      ),
      Wrap(
          children: controller.morningTimes
              .map((Time time) => TimeButton(
                  label:
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                  isSelected:
                      controller.selectedTimes.contains(time), // 08:00 AM'
                  onTap: () => controller.setSelectedTime(time)))
              .toList()),
      const SizedBox(
        height: 20,
      ),
      const LabelButton(label: 'Night', icon: Icons.nightlight_outlined),
      const SizedBox(
        height: 16,
      ),
      Wrap(
          children: controller.nightTimes
              .map((Time time) => TimeButton(
                  label:
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                  isSelected:
                      controller.selectedTimes.contains(time), // 08:00 AM'
                  onTap: () => controller.setSelectedTime(time)))
              .toList()),
    ];
  }

  List<Widget> _buildReminderInterval() {
    return [
      const Text(
        'Reminder Interval',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Palette.secondary),
      ),
      const SizedBox(
        height: 10,
      ),
      Wrap(
          children: controller.intervals
              .map((interval) => DecoratedText(
                  label: interval.value,
                  isSelected: controller.selectedInterval.value == interval,
                  onTap: () => controller.setSelectedInterval(interval)))
              .toList()),
    ];
  }
}
