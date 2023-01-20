import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({super.key});
  static const String routeName = "/profile-edit";
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
                      isEnabled: false,
                      labelText: 'Email Address',
                      hintText: 'Enter your email address',
                      editingCtrl: controller.emailCtrl,
                    ),
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
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Save Changes',
                        disabled: controller.isLoadingSaveProfile.value,
                        loading: controller.isLoadingSaveProfile.value,
                        press: () async {
                          if (controller.signUpFormKey.currentState!
                              .validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.edit_outlined,
                                promptText:
                                    'Are you sure you want to save\n these changes?',
                                confirmText: 'Save',
                                onConfirmPress: () async {
                                  Get.back();
                                  await controller.saveProfile();
                                },
                                isDismissible: true);
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
