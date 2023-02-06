import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/auth/signup/signup_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'signin_controller.dart';

class SignInView extends GetView<SignInController> {
  SignInView({super.key});
  static const String routeName = "/signin";
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
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
                    const FormHeader(
                      title: 'Welcome back',
                      text: 'Sign in to your account',
                    ),
                    AppTextField(
                      labelText: 'Email Address',
                      hintText: 'Enter your email address',
                      editingCtrl: controller.emailCtrl,
                    ),
                    AppPasswordField(
                      labelText: 'Password',
                      editingCtrl: controller.passwordCtrl,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed('forgot-password');
                          },
                          child: const Text(
                            'Forgot password?',
                            style:
                                TextStyle(fontSize: 12, color: Palette.primary),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Sign in',
                        loading: controller.isLoadingSignIn.value,
                        disabled: controller.isLoadingSignIn.value,
                        press: () async {
                          if (loginFormKey.currentState!.validate()) {
                            await controller.signIn(
                                email: controller.emailCtrl.text.trim(),
                                password: controller.passwordCtrl.text.trim());
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    AccountCTA(
                        text: 'Don\'t have an account?',
                        onTap: () => Get.toNamed(SignUpView.routeName),
                        linkText: 'Sign up'),
                  ],
                ))),
          ),
        ));
  }
}
