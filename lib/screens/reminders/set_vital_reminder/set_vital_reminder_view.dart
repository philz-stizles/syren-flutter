import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'set_vital_reminder_controller.dart';

class SetVitalReminderView extends GetView<SetVitalReminderController> {
  SetVitalReminderView({super.key});
  static String routeName = "/set-vital-reminder";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Vitals (Reminder)')),
        body: Obx(() {
          final morningTime = controller.morningTime.value;
          final morningHours = morningTime.hour.toString().padLeft(2, '0');
          final morningMinutes = morningTime.minute.toString().padLeft(2, '0');
          final nightTime = controller.nightTime.value;
          final nightHours = nightTime.hour.toString().padLeft(2, '0');
          final nightMinutes = nightTime.minute.toString().padLeft(2, '0');
          return SingleChildScrollView(
            child: Padding(
                padding: defaultScreenPadding,
                child: Form(
                    key: controller.vitalReminderFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          labelText: 'Reminder for checking',
                          hintText: 'Select Vital',
                          editingCtrl: controller.vitalCtrl,
                        ),
                        const Text('Specify Time',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: Palette.primary,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Text('Morning',
                                            style: TextStyle(
                                                color: Palette.white,
                                                fontSize: 14)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.wb_cloudy_outlined,
                                            color: Palette.white)
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                        initialEntryMode:
                                            TimePickerEntryMode.input,
                                        context: context,
                                        initialTime:
                                            controller.morningTime.value);
                                    if (newTime == null) {
                                      return;
                                    } else {
                                      controller.morningTime.value = newTime;
                                    }
                                  },
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 10, 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('$morningHours:$morningMinutes',
                                              style: const TextStyle(
                                                  color: Palette.brown,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(Icons.arrow_drop_down,
                                              color: Palette.brown)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: Palette.primary,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Text('Night',
                                            style: TextStyle(
                                                color: Palette.white,
                                                fontSize: 14)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.mode_night_outlined,
                                            color: Palette.white)
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                        initialEntryMode:
                                            TimePickerEntryMode.input,
                                        context: context,
                                        initialTime:
                                            controller.nightTime.value);

                                    if (newTime == null) {
                                      return;
                                    } else {
                                      controller.nightTime.value = newTime;
                                    }
                                  },
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 10, 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('$nightHours:$nightMinutes',
                                              style: const TextStyle(
                                                  color: Palette.brown,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(Icons.arrow_drop_down,
                                              color: Palette.brown)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                            'Note: This is to Remind you to check your Blood Sugar Daily, Always stay healthy',
                            style: TextStyle(fontSize: 12)),
                        const SizedBox(
                          height: 30,
                        ),
                        PrimaryButton(
                            title: 'Set Reminder',
                            press: () async => {
                                  if (controller
                                      .vitalReminderFormKey.currentState!
                                      .validate())
                                    {
                                      await controller.addReminder(
                                          nightTime.hour, nightTime.minute)
                                    }
                                })
                      ],
                    ))),
          );
        }));
  }
}
