import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'home_visit_controller.dart';

class HomeVisitView extends GetView<HomeVisitController> {
  HomeVisitView({super.key});

  final bpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              key: bpFormKey,
                child: Column(
              children: [
                const FormHeader(
                  title: 'Input your blood pressure vitals.',
                  text: 'Sign in to your account',
                ),
                AppTextField(
                  labelText: 'Systolic Pressure',
                  hintText: 'Input value',
                  editingCtrl: controller.systolicController,
                ),
                AppTextField(
                  labelText: 'Diastolic Pressure',
                  hintText: 'Input value',
                  editingCtrl: controller.diastolicController,
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                    title: 'Enter Blood Pressure',
                    loading: controller.isLoadingSignIn.value,
                    press: () async {
                    if(bpFormKey.currentState!.validate()) {
                      await controller.signIn();                    }
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
