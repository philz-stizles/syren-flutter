import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
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
      body: Padding(
          padding: defaultScreenPadding,
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: PrimaryButton(
                        title: 'Medications',
                        outlined: controller.page.value != 0,
                        press: () {
                          controller.page.value = 0;
                        },
                        expanded: false,
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: PrimaryButton(
                        title: 'Vitals',
                        outlined: controller.page.value != 1,
                        press: () {
                          controller.page.value = 1;
                        },
                        expanded: false,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ...controller.page.value == 0
                      ? _buildMedications()
                      : _buildVitals(
                          controller.vitalReminderCtrl.vitalReminders)
                ],
              ))),
      bottomNavigationBar:
          AppBottomNavigationBar(currentIndex: 2, onTap: ((value) {})),
    );
  }

  List<Widget> _buildMedications() {
    return [
      const JumbotronCard(
          image: 'assets/images/medication-reminder.jpg',
          caption: 'With Syren, You’ll never\n miss your Medications'),
      const SizedBox(
        height: 30,
      ),
      const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'You have no reminder set',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
            color: Palette.primary, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: const [
              Text(
                'Morning Medications',
                style: TextStyle(color: Palette.white, fontSize: 12),
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
                    controller.morningMedications.value = newValue;
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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: const [
                  Text(
                    'Gliclazide (80g)',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Palette.secondary),
                  ),
                  Icon(Icons.medication, size: 20, color: Palette.secondary),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Take 2 tablets',
                style: TextStyle(fontSize: 12, color: Palette.brown),
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.alarm, size: 20, color: Palette.secondary),
                Text(
                  '08:45PM',
                  style: TextStyle(fontSize: 12, color: Palette.secondary),
                ),
              ],
            )
          ],
        ),
      )
    ];
  }

  List<Widget> _buildVitals(List<VitalReminderModel> vitalReminders) {
    return [
      const JumbotronCard(
          image: 'assets/images/medication-reminder.jpg',
          caption: 'With Syren, You’re sure to have\n stable blood vitals.'),
      const SizedBox(
        height: 20,
      ),
      TextIconButton(
        label: 'Add New',
        onPress: () {
          Get.toNamed(SetVitalReminderView.routeName);
        },
        trailingIcon: Icons.add_circle_outline,
      ),
      const SizedBox(
        height: 20,
      ),
      const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'You have no reminder set',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          )),
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: BoxDecoration(
            color: Palette.primary, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: const [
              Text(
                'Morning Vitals',
                style: TextStyle(color: Palette.white, fontSize: 12),
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
                    controller.morningMedications.value = newValue;
                  }),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      Expanded(
          child: ListView.builder(
              itemCount: vitalReminders.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                var reminder = vitalReminders[index];
                return ReminderCard(
                    title: reminder.title,
                    note: reminder.note,
                    time: '08:45PM');
              })))
    ];
  }
}
