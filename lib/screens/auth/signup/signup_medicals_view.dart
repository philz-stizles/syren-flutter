import 'package:flutter/material.dart';
import 'package:syren/screens/auth/signin/signin_view.dart';
import 'package:get/get.dart';
import 'package:syren/screens/auth/signup/signup_controller.dart';

import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';

class SignUpMedicalsView extends StatelessWidget {
  SignUpMedicalsView({super.key});
  static const String routeName = "/signup-medicals";
  final signUpMedicalsFormKey = GlobalKey<FormState>();
  final signupCtrl = Get.find<SignUpController>();

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
                key: signUpMedicalsFormKey,
                child: Column(
                  children: [
                    const FormHeader(
                      title: 'Set up your medical records',
                    ),
                    DropdownSelectField(
                      labelText: 'Do you have any allergies',
                      options: signupCtrl.alleries,
                      onChanged: (String? val) {
                        signupCtrl.allergiesDropdownValue.value = val;
                      },
                      dropdownValue: signupCtrl.allergiesDropdownValue.value,
                    ),
                    AppTextField(
                      labelText: 'If yes, state it',
                      hintText: 'Enter your allergies',
                      editingCtrl: signupCtrl.allergiesCtrl,
                      validationText: 'Please provide valid allergies',
                    ),
                    AppTextField(
                      labelText: 'What medications do you take daily?',
                      hintText: 'Enter medications',
                      editingCtrl: signupCtrl.medicationsCtrl,
                      validationText: 'Please provide valid medications',
                    ),
                    DropdownSelectField(
                      labelText: 'Do you have any medical conditions',
                      options: signupCtrl.conditions,
                      onChanged: (String? val) {
                        signupCtrl.conditionsDropdownValue.value = val;
                      },
                      dropdownValue: signupCtrl.conditionsDropdownValue.value,
                    ),
                    AppTextField(
                      labelText: 'If yes, state it',
                      hintText: 'Enter your conditions',
                      editingCtrl: signupCtrl.conditionsCtrl,
                      validationText: 'Please provide valid conditions',
                    ),
                    DropdownSelectField(
                      labelText: 'What is your Genotype?',
                      options: signupCtrl.genoTypes,
                      onChanged: (String? val) {
                        signupCtrl.genoTypeDropdownValue.value = val;
                      },
                      dropdownValue: signupCtrl.genoTypeDropdownValue.value,
                    ),
                    DropdownSelectField(
                      labelText: 'What is your Blood Group?',
                      options: signupCtrl.bloodGroups,
                      onChanged: (String? val) {
                        signupCtrl.bloodGroupDropdownValue.value = val;
                      },
                      dropdownValue: signupCtrl.bloodGroupDropdownValue.value,
                    ),
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
                    PrimaryButton(
                        title: 'Sign up',
                        disabled: signupCtrl.isLoadingSignUp.value,
                        loading: signupCtrl.isLoadingSignUp.value,
                        press: () async {
                          if (signUpMedicalsFormKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            await signupCtrl.otpVerification();
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    signupCtrl.userSrv.authUser.value == null
                        ? AccountCTA(
                            text: 'Already have an account?',
                            onTap: () => Get.offNamed(SignInView.routeName),
                            linkText: 'Sign in')
                        : const SizedBox()
                  ],
                ))),
          ),
        ));
  }
}
