import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syren/screens/auth/signin/signin_view.dart';
import 'package:get/get.dart';
import 'package:syren/screens/auth/signup/signup_controller.dart';
import 'package:syren/screens/auth/signup/signup_medicals_view.dart';

import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';

class SignUpView extends GetView<SignUpController> {
  SignUpView({super.key});
  static const String routeName = "/signup";

  final signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading:
                controller.userSrv.authUser.value == null ? false : true,
            title: Image.asset(
              'assets/images/logo.png',
              scale: 1.2,
              fit: BoxFit.cover,
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: signUpFormKey,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: DropdownSelectField(
                            labelText: 'Gender',
                            options: controller.genderTypes,
                            onChanged: (String? val) {
                              controller.genderDropdownValue.value = val;
                            },
                            dropdownValue: controller.genderDropdownValue.value,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Expanded(
                        //   child: DropdownSelectField(
                        //     labelText: 'Religion',
                        //     options: controller.religionTypes,
                        //     onChanged: (String? val) {
                        //       controller.religionDropdownValue.value = val;
                        //     },
                        //     dropdownValue:
                        //         controller.religionDropdownValue.value,
                        //     // initialValue: 'Christian',
                        //   ),
                        // )
                      ],
                    ),
                    AppPhoneField(
                        type: TextInputType.phone,
                        labelText: 'Contact',
                        hintText: 'Phone Number',
                        editingCtrl: controller.phoneCtrl,
                        onChange: (code) {
                          controller.phoneCountryCode.value = code.dialCode!;
                        }),
                    
                    // ),
                    // AppTextField(
                    //   type: TextInputType.number,
                    //   labelText: 'Contact',
                    //   hintText: '+234',
                    //   editingCtrl: controller.phoneCtrl,
                    // ),
                    Focus(
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus) {
                            controller.isCheckingEmail(true);
                            var exists = await controller.userSrv
                                .checkIfEmailExists(
                                    controller.emailCtrl.text.trim());
                            controller.isCheckingEmail(false);
                            if (exists) {
                              controller.emailExists.value = true;
                            } else {
                              controller.emailExists.value = false;
                            }

                            controller.emailKey.currentState!.validate();
                          }
                        },
                        child: AppTextField(
                          labelText: 'Email Address',
                          hintText: 'Enter your email address',
                          editingCtrl: controller.emailCtrl,
                          formFieldKey: controller.emailKey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a valid email address';
                            } else if (controller.emailExists.value) {
                              return 'This email is already taken';
                            } else {
                              return null;
                            }
                          },
                        )),
                    DateInputField(
                      labelText: 'Date of Birth',
                      icon: Icons.calendar_month,
                      iconTap: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());
                        if (newDate == null) {
                          return;
                        } else {
                          controller.dobCtrl.text =
                              DateFormat('y/MM/dd').format(newDate).toString();
                        }
                      },
                      hintText: DateFormat('y/MM/dd')
                          .format(DateTime.now())
                          .toString(),
                      editingCtrl: controller.dobCtrl,
                    ),
                    AppPasswordField(
                      labelText: 'Password',
                      editingCtrl: controller.passwordCtrl,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Next',
                        loading: controller.isLoadingSignUp.value,
                        press: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (signUpFormKey.currentState!.validate()) {
                            if (controller.dobCtrl.text.isNotEmpty) {
                              if (Get.isSnackbarOpen) {
                                Get.closeCurrentSnackbar();
                              }
                              Get.toNamed(SignUpMedicalsView.routeName);
                              // await controller.signUp();
                            } else {
                              UIConfig.showSnackBar(
                                  message:
                                      'Please, kindly provide your date of birth',
                                  backgroundColor: Colors.red);
                            }
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.userSrv.authUser.value == null
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
