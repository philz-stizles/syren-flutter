import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/reminders/reminders_controller.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class RemindersView extends StatelessWidget {
  RemindersView({super.key});
  static const String routeName = "/reminders";

  final reminderCtrl = Get.put(RemindersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          outlined: reminderCtrl.page.value != 0,
                          press: () {
                            reminderCtrl.page.value = 0;
                          },
                          expanded: false,
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: PrimaryButton(
                          title: 'Vitals',
                          outlined: reminderCtrl.page.value != 1,
                          press: () {
                            reminderCtrl.page.value = 1;
                          },
                          expanded: false,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...reminderCtrl.page.value == 0
                        ? _buildPage(
                            reminders: reminderCtrl.reminderSrv.reminders
                                .where((ReminderModel model) =>
                                    model.notificationType ==
                                    NotificationType.medReminder)
                                .toList(),
                            image: 'assets/images/medication-reminder.jpg',
                            caption:
                                'With Syren, you’ll never\n miss your medications',
                            addRoute: SetMedReminderView.routeName,
                            onClear: () async => await reminderCtrl
                                .clear(NotificationType.medReminder))
                        : _buildPage(
                            reminders: reminderCtrl.reminderSrv.reminders
                                .where((ReminderModel model) =>
                                    model.notificationType ==
                                    NotificationType.vitalReminder)
                                .toList(),
                            image: 'assets/images/vitals.jpg',
                            caption:
                                'With Syren, you’re sure to have \n stable blood vitals',
                            addRoute: SetVitalReminderView.routeName,
                            onClear: () async => await reminderCtrl
                                .clear(NotificationType.vitalReminder))
                  ],
                ))));
  }

  List<Widget> _buildPage(
      {List<ReminderModel> reminders = const [],
      required String image,
      required String caption,
      required String addRoute,
      required void Function() onClear}) {
    var morningMeds = reminders
        .where((element) => DateTime.parse(element.date!).hour <= 12)
        .toList();
    var eveningMeds = reminders
        .where((element) => DateTime.parse(element.date!).hour > 12)
        .toList();

    return [
      JumbotronCard(image: image, caption: caption),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextIconButton(
            label: 'Setup New',
            onPress: () {
              Get.toNamed(addRoute);
            },
            trailingIcon: Icons.add_circle_outline,
          ),
          TextIconButton(
            label: 'Clear',
            onPress: onClear,
            trailingIcon: Icons.clear_outlined,
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      ...reminders.isEmpty
          ? [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'You have no reminder set',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ))
            ]
          : [
              ...morningMeds.isNotEmpty
                  ? [
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
                                style: TextStyle(
                                    color: Palette.white, fontSize: 12),
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
                                  value: reminderCtrl.morningMedications.value,
                                  onChanged: (bool newValue) {
                                    reminderCtrl.morningMedications.value =
                                        newValue;
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
                              itemCount: morningMeds.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                var reminder = morningMeds[index];
                                debugPrint(
                                    reminder.notificationType.toString());
                                return ReminderCard(
                                    title: reminder.title,
                                    note: reminder.note,
                                    time: DateFormat('HH:mm a')
                                        .format(DateTime.parse(reminder.date!))
                                        .toString());
                              })))
                    ]
                  : [],
              ...eveningMeds.isNotEmpty
                  ? [
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
                                'Evening Medications',
                                style: TextStyle(
                                    color: Palette.white, fontSize: 12),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.nightlight_outlined,
                                color: Palette.white,
                                size: 20,
                              )
                            ]),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                  value: reminderCtrl.eveningMedications.value,
                                  onChanged: (bool newValue) {
                                    reminderCtrl.eveningMedications.value =
                                        newValue;
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
                              itemCount: eveningMeds.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                var reminder = eveningMeds[index];
                                debugPrint(
                                    reminder.notificationType.toString());
                                return ReminderCard(
                                    title: reminder.title,
                                    note: reminder.note,
                                    time: DateFormat('HH:mm a')
                                        .format(DateTime.parse(reminder.date!))
                                        .toString());
                              })))
                    ]
                  : []
            ]
    ];
  }
}
