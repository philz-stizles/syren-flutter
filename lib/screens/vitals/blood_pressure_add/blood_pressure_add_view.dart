import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'blood_pressure_add_controller.dart';

class BloodPressureAddView extends GetView<BloodPressureAddController> {
  BloodPressureAddView({super.key});
  static const String routeName = "/blood-pressure-add";

  final bpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Blood Pressure')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: bpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Input your blood pressure vitals.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      type: TextInputType.number,
                      labelText: 'Systolic Pressure',
                      hintText: 'Input value',
                      editingCtrl: controller.systolicCtrl,
                    ),
                    AppTextField(
                      type: TextInputType.number,
                      labelText: 'Diastolic Pressure',
                      hintText: 'Input value',
                      editingCtrl: controller.diastolicCtrl,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                        title: 'Enter Blood Pressure',
                        disabled: controller.isLoadingSaveBp.value,
                        loading: controller.isLoadingSaveBp.value,
                        press: () async {
                          if (bpFormKey.currentState!.validate()) {
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.save_outlined,
                                promptText:
                                    'Are you sure you want to save these\n blood pressure vitals?',
                                onConfirmPress: () async {
                                  Get.back();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  await controller.saveBp();
                                });
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Previous blood pressure level.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ))),
          ),
        ));
  }
}
