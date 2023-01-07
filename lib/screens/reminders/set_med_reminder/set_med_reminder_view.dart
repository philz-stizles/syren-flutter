import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'set_med_reminder_controller.dart';

class SetMedReminderView extends GetView<SetMedReminderController> {
  SetMedReminderView({super.key});
  static String routeName = "/set-med-reminder";
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dimWhite,
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('Set Reminder')),
      body: SingleChildScrollView(
        child: Padding(
            padding: defaultScreenPadding,
            child: Column(
              children: [
                AppTextField(
                  labelText: 'Drug Name',
                  hintText: 'Enter the drug name',
                  editingCtrl: controller.nameCtrl,
                ),
                AppTextField(
                  labelText: 'Amount Selected',
                  hintText: 'Type the amount',
                  editingCtrl: controller.amountCtrl,
                ),
                DropdownSelectField(
                  labelText: 'Gender',
                  editingCtrl: controller.drugTypeCtrl,
                  options: controller.drugTypes,
                  onChanged: (String? val) {
                    controller.drugTypeCtrl.text = val!;
                    controller.drugTypeDropdownValue.value = val;
                  },
                  dropdownValue: controller.drugTypeDropdownValue.value,
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(title: 'Set Reminder', press: () {})
              ],
            )),
      ),
    );
  }
}
