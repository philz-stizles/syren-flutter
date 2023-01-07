import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/signup/signup_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'signin_controller.dart';

class SignInView extends GetView<SignInController> {
  SignInView({super.key});
  static String routeName = "/signin";
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
                      title: 'Welcome back',
                      text: 'Sign in to your account',
                    ),
                    AppTextField(
                      labelText: 'Email Address',
                      hintText: 'Enter your email address',
                      editingCtrl: controller.emailController,
                    ),
                    AppPasswordField(
                      labelText: 'Password',
                      editingCtrl: controller.passwordController,
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
                        press: () async {
                          if (loginFormKey.currentState!.validate()) {
                            await controller.signIn();
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
