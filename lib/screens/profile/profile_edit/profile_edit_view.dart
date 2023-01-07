import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/signup/signup_medicals_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({super.key});
  static String routeName = "/profile-edit";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true, title: const Text('Edit Profile')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: controller.signUpFormKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
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
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Save Changes',
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
                  ],
                ))),
          ),
        ));
  }
}
