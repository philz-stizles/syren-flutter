import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'blood_sugar_add_controller.dart';

class BloodSugarAddView extends GetView<BloodSugarAddController> {
  BloodSugarAddView({super.key});
  static String routeName = "/blood-sugar-add";

  final bpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true, title: const Text('Blood Sugar')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: bpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Input your blood sugar vitals.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      type: TextInputType.number,
                      labelText: 'Fasting Test (8 Hours after last meal) ',
                      hintText: 'Input value',
                      editingCtrl: controller.fastingCtrl,
                    ),
                    AppTextField(
                      type: TextInputType.number,
                      labelText: 'Random Test (Take anytime)',
                      hintText: 'Input value',
                      editingCtrl: controller.randomCtrl,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                        title: 'Enter Blood Sugar',
                        disabled: controller.isLoadingSaveBs.value,
                        loading: controller.isLoadingSaveBs.value,
                        press: () async {
                          if (bpFormKey.currentState!.validate()) {
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.save_outlined,
                                promptText:
                                    'Are you sure you want to save these\n blood sugar vitals?',
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
                      'Previous blood sugar level.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ))),
          ),
        ));
  }
}
