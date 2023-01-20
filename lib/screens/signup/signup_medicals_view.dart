import 'package:flutter/material.dart';
import 'package:syren/screens/signin/signin_view.dart';
import 'package:get/get.dart';
import 'package:syren/screens/signup/signup_controller.dart';

import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class SignUpMedicalsView extends GetView<SignUpController> {
  SignUpMedicalsView({super.key});
  static const String routeName = "/signup-medicals";
  final signUpMedicalsFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
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
                key: signUpMedicalsFormKey,
                child: Column(
                  children: [
                    const FormHeader(
                      title: 'Set up your medical records',
                    ),
                    DropdownSelectField(
                      labelText: 'Do you have any allergies',
                      editingCtrl: controller.hasAllergiesCtrl,
                      options: controller.alleries,
                      onChanged: (String? val) {},
                      dropdownValue: controller.hasAllergiesDropdownValue.value,
                    ),
                    AppTextField(
                      labelText: 'If yes, state it',
                      hintText: 'Enter your allergies',
                      editingCtrl: controller.allergiesCtrl,
                    ),
                    AppTextField(
                      labelText: 'What medications do you take daily?',
                      hintText: 'Enter medications',
                      editingCtrl: controller.medicationsCtrl,
                    ),
                    DropdownSelectField(
                      labelText: 'Do you have any medical conditions',
                      editingCtrl: controller.hasConditionsCtrl,
                      options: controller.conditions,
                      onChanged: (String? val) {},
                      dropdownValue:
                          controller.hasConditionsDropdownValue.value,
                    ),
                    AppTextField(
                      labelText: 'If yes, state it',
                      hintText: 'Enter your conditions',
                      editingCtrl: controller.conditionsCtrl,
                    ),
                    DropdownSelectField(
                      labelText: 'What is your Genotype?',
                      editingCtrl: controller.genoTypeCtrl,
                      options: controller.genoTypes,
                      onChanged: (String? val) {
                        controller.genoTypeCtrl.text = val!;
                        controller.genoTypeDropdownValue.value = val;
                      },
                      dropdownValue: controller.genoTypeDropdownValue.value,
                    ),
                    DropdownSelectField(
                      labelText: 'What is your Blood Group?',
                      editingCtrl: controller.bloodGroupCtrl,
                      options: controller.bloodGroups,
                      onChanged: (String? val) {
                        controller.bloodGroupCtrl.text = val!;
                        controller.bloodGroupDropdownValue.value = val;
                      },
                      dropdownValue: controller.bloodGroupDropdownValue.value,
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
                        loading: controller.isLoadingSignUp.value,
                        press: () async {
                          if (signUpMedicalsFormKey.currentState!.validate()) {
                            await controller.signUp();
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    AccountCTA(
                        text: 'Already have an account?',
                        onTap: () => Get.off(() => SignInView()),
                        linkText: 'Sign in'),
                  ],
                ))),
          ),
        ));
  }
}
