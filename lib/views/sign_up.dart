import 'package:flutter/material.dart';
import 'package:syren/views/sign_in.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                const FormHeader(text: 'Create an account with us today'),
                const AppTextField(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
                const RadioButtonField(
                  labelText: 'Sex',
                  options: ['Male', 'Female'],
                ),
                const RadioButtonField(
                    labelText: 'Religion',
                    options: ['Christian', 'Muslim', 'Other']),
                const AppTextField(
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                ),
                AppPasswordField(labelText: 'Password'),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: InkWell(
                    onTap: () {
                      // signupStep1Ctrl.gotoPrivacyPolicy();
                    },
                    child: const Text(
                      'I have read and accepted the privacy policy',
                      // style: AppTextStyles.defaultStyle.copyWith(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w600,
                      //     color: Colors.red,
                      //     decoration: TextDecoration.underline),
                    ),
                  ),
                  value: true, // 'signupStep1Ctrl.isChecked.value',
                  onChanged: (val) {
                    // signupStep1Ctrl.isChecked(val!);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(title: 'Sign up', press: () {}),
                const SizedBox(
                  height: 30,
                ),
                AccountCTA(
                    text: 'Already have an account?',
                    onTap: () => Get.to(() => const SignInScreen()),
                    linkText: 'Sign in'),
              ],
            )),
          ),
        ));
  }
}
