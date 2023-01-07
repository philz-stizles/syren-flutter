import 'package:flutter/material.dart';
import 'package:syren/screens/signin/signin_view.dart';
import 'package:get/get.dart';
import 'package:syren/screens/signup/signup_controller.dart';
import 'package:syren/screens/signup/signup_medicals_view.dart';

import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  static String routeName = "/signup";
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
                key: controller.signUpFormKey,
                child: Column(
                  children: [
                    const FormHeader(
                      title: 'Are you new?',
                      text: 'Create an account with us today',
                    ),
                    AppTextField(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      editingCtrl: controller.nameCtrl,
                    ),
                    DropdownSelectField(
                      labelText: 'Gender',
                      editingCtrl: controller.genderCtrl,
                      options: controller.genderTypes,
                      onChanged: (String? val) {
                        controller.genderCtrl.text = val!;
                        controller.genderDropdownValue.value = val;
                      },
                      dropdownValue: controller.genderDropdownValue.value,
                    ),
                    DropdownSelectField(
                      labelText: 'Religion',
                      editingCtrl: controller.religionCtrl,
                      options: controller.religionTypes,
                      onChanged: (String? val) {
                        controller.religionCtrl.text = val!;
                        controller.religionDropdownValue.value = val;
                      },
                      dropdownValue: controller.religionDropdownValue.value,
                      // initialValue: 'Christian',
                    ),
                    AppTextField(
                      type: TextInputType.number,
                      labelText: 'Contact',
                      hintText: '+234',
                      editingCtrl: controller.phoneCtrl,
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
                    // CheckboxListTile(
                    //   contentPadding: const EdgeInsets.symmetric(
                    //       horizontal: 0.0, vertical: 0.0),
                    //   dense: true,
                    //   controlAffinity: ListTileControlAffinity.leading,
                    //   title: InkWell(
                    //     onTap: () {
                    //       // signupStep1Ctrl.gotoPrivacyPolicy();
                    //     },
                    //     child: const Text(
                    //       'I have read and accepted the privacy policy',
                    //       style: TextStyle(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w600,
                    //           color: Palette.primary,
                    //           decoration: TextDecoration.underline),
                    //     ),
                    //   ),
                    //   value: true, // 'signupStep1Ctrl.isChecked.value',
                    //   onChanged: (val) {
                    //     // signupStep1Ctrl.isChecked(val!);
                    //   },
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Next',
                        loading: controller.isLoadingSignUp.value,
                        press: () async {
                          if (controller.signUpFormKey.currentState!
                              .validate()) {
                            Get.toNamed(SignUpMedicalsView.routeName);
                            // await controller.signUp();
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    AccountCTA(
                        text: 'Already have an account?',
                        onTap: () => Get.offNamed(SignInView.routeName),
                        linkText: 'Sign in'),
                  ],
                ))),
          ),
        ));
  }
}
