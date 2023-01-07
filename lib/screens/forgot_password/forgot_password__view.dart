import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({super.key});
  static String routeName = "/forgot-password";
  final loginFormKey = GlobalKey<FormState>();

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
                key: loginFormKey,
                child: Column(
                  children: [
                    const FormHeader(
                      title: 'Forgot your password?',
                      text: 'Recieve an email to reset your password.',
                    ),
                    AppTextField(
                      labelText: 'Email Address',
                      hintText: 'Enter your email address',
                      editingCtrl: controller.emailController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Reset Password',
                        loading: controller.isLoadingForgotPassword.value,
                        press: () async {
                          if (loginFormKey.currentState!.validate()) {
                            await controller.resetPassword();
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    AccountCTA(
                        text: 'Don\'t have an account?',
                        onTap: () => Get.toNamed('signup'),
                        linkText: 'Sign up'),
                  ],
                ))),
          ),
        ));
  }
}
