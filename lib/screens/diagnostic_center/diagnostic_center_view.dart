import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'diagnostic_center_controller.dart';

class DiagnosticCenterView extends GetView<DiagnosticCenterController> {
  DiagnosticCenterView({super.key});

  final bsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.medical_services),
              SizedBox(
                width: 5,
              ),
              Text('Syren')
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: bsFormKey,
                child: Column(
                  children: [
                    const FormHeader(
                      title: 'Input Blood Sugar Vitals.',
                      text: '',
                    ),
                    AppTextField(
                      labelText: 'Fasting Test(8 hours adter last meal.)',
                      hintText: 'Input value',
                      editingCtrl: controller.fastingController,
                    ),
                    AppTextField(
                      labelText: 'Random Test(Take anytime.)',
                      hintText: 'Input value',
                      editingCtrl: controller.randomController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Enter Blood Sugar',
                        loading: controller.isLoadingSignIn.value,
                        press: () async {
                          if (bsFormKey.currentState!.validate()) {
                            await controller.signIn();
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
