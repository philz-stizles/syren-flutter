import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/medications/medications_view.dart';
import 'package:syren/screens/reminders/set_med_reminder/set_med_reminder_view.dart';
import 'package:syren/screens/vitals/vitals_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/navigation_bar.dart';
import 'package:syren/widgets/widgets.dart';

import 'reminders_controller.dart';

class RemindersView extends GetView<RemindersController> {
  const RemindersView({super.key});
  static String routeName = "/reminders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dimWhite,
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text('Reminders')),
      body: SingleChildScrollView(
        child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: PrimaryButton(
                          title: 'Medications',
                          press: () => MedicationsView.routeName,
                          expanded: false,
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: PrimaryButton(
                          title: 'Vitals',
                          outlined: true,
                          press: () => VitalsView.routeName,
                          expanded: false,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const JumbotronCard(
                        image: 'assets/images/medication-reminder.jpg',
                        caption:
                            'With Syren, You’ll never\n miss your Medications'),
                    const SizedBox(
                      height: 30,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'You have no reminder set',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextIconButton(
                      label: 'Add New',
                      onPress: () {
                        Get.toNamed(SetMedReminderView.routeName);
                      },
                      trailingIcon: Icons.add_circle_outline,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Palette.primary,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(children: const [
                            Text(
                              'Morning Medications',
                              style:
                                  TextStyle(color: Palette.white, fontSize: 12),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.cloud_outlined,
                              color: Palette.white,
                              size: 20,
                            )
                          ]),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                                value: controller.morningMedications.value,
                                onChanged: (bool newValue) {
                                  controller.morningMedications.value =
                                      newValue;
                                }),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Palette.secondary),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Gliclazide (80g)',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.secondary),
                                    ),
                                    Icon(Icons.medication,
                                        size: 20, color: Palette.secondary),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Take 2 tablets',
                                  style: TextStyle(
                                      fontSize: 12, color: Palette.brown),
                                ),
                              ]),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.alarm,
                                  size: 20, color: Palette.secondary),
                              Text(
                                '08:45PM',
                                style: TextStyle(
                                    fontSize: 12, color: Palette.secondary),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ))),
      ),
      bottomNavigationBar:
          AppBottomNavigationBar(currentIndex: 2, onTap: ((value) {})),
    );
  }
}
