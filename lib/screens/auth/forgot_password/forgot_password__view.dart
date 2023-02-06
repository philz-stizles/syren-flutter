import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({super.key});
  static const String routeName = "/forgot-password";
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Image.asset(
              'assets/images/logo.png',
              scale: 1.2,
              fit: BoxFit.cover,
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const FormHeader(
                      title: 'Forgot your password?',
                      text:
                          'Enter the email address associated\n with your account.',
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
