import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  ChangePasswordView({super.key});
  static String routeName = "/change-password";
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Change Passowrd')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    AppTextField(
                      hintText: 'Current Password',
                      editingCtrl: controller.currentCtrl,
                    ),
                    AppTextField(
                      hintText: 'New Password',
                      editingCtrl: controller.newCtrl,
                    ),
                    AppTextField(
                      hintText: 'Confirm Password',
                      editingCtrl: controller.confirmCtrl,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Save Changes',
                        loading: controller.isLoadingChangePassword.value,
                        press: () async {
                          if (loginFormKey.currentState!.validate()) {
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.security,
                                promptText:
                                    'Are you sure you want to change\n your password?',
                                onConfirmPress: () =>
                                    controller.changePassword());
                          }
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    PrimaryButton(
                        outlined: true,
                        title: 'Cancel',
                        press: () async {
                          Get.back();
                        }),
                  ],
                ))),
          ),
        ));
  }
}
