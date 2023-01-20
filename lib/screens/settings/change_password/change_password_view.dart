import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  static const String routeName = "/change-password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Change Password')),
      body: SingleChildScrollView(
        child: Padding(
          padding: defaultScreenPadding,
          child: Obx(() => Form(
              key: controller.changePassFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Palette.midGrey, width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lock_person),
                          const SizedBox(
                            width: 15,
                          ),
                          Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                Text(
                                  'Change Password',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Its a good idea to use a very strong password so as to avoid your account being used elsewhere',
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 12),
                                )
                              ]))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppPasswordField(
                    hintText: 'Current Password',
                    editingCtrl: controller.currentCtrl,
                  ),
                  AppPasswordField(
                    hintText: 'New Password',
                    editingCtrl: controller.newCtrl,
                  ),
                  AppPasswordField(
                    hintText: 'Confirm Password',
                    editingCtrl: controller.confirmCtrl,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                      title: 'Save Changes',
                      disabled: controller.isLoadingChangePassword.value,
                      loading: controller.isLoadingChangePassword.value,
                      press: () async {
                        if (controller.changePassFormKey.currentState!
                            .validate()) {
                          if (controller.newCtrl.text.trim() !=
                              controller.confirmCtrl.text.trim()) {
                            UIConfig.showSnackBar(
                                message: 'Passwords must match',
                                backgroundColor: Colors.red);
                          } else {
                            FocusManager.instance.primaryFocus?.unfocus();
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.lock_person,
                                promptText:
                                    'Are you sure you want to change\n your password?',
                                onConfirmPress: () async {
                                  Get.back();
                                  await controller.changePassword();
                                });
                          }
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  PrimaryButton(
                      disabled: controller.isLoadingChangePassword.value,
                      outlined: true,
                      title: 'Cancel',
                      press: () async {
                        Get.back();
                      }),
                ],
              ))),
        ),
      ),
      // bottomNavigationBar: AppBottomNavigationBar(
      //     currentIndex: 3,
      //     onTap: ((value) {
      //       // Get.to(SettingsView());
      //     })),
    );
  }
}
