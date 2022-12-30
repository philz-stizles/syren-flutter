import 'package:flutter/material.dart';
import 'package:syren/views/dashboard.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../widgets/widgets.dart';
import 'sign_up.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
            child: Form(
                child: Column(
              children: [
                const FormHeader(
                  title: 'Welcome back\nSign in to your account',
                  text: '',
                ),
                const AppTextField(
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                ),
                AppPasswordField(
                  labelText: 'Password',
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                    title: 'Sign in',
                    press: () {
                      Get.offAll(const DashboardScreen());
                    }),
                const SizedBox(
                  height: 30,
                ),
                AccountCTA(
                    text: 'Don\'t have an account?',
                    onTap: () => Get.to(() => const SignUpScreen()),
                    linkText: 'Sign up'),
              ],
            )),
          ),
        ));
  }
}
