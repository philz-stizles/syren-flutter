import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'medical_record_edit_controller.dart';

class MedicalRecordEditView extends GetView<MedicalRecordEditController> {
  MedicalRecordEditView({super.key});
  static String routeName = "/medical-record-edit";
  final signUpMedicalsFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Edit Medical Records')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Obx(() => Form(
                key: signUpMedicalsFormKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
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
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Save Changes',
                        loading: controller.isLoadingSignUp.value,
                        press: () async {
                          if (signUpMedicalsFormKey.currentState!.validate()) {
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.edit,
                                promptText:
                                    'Are sure you want to save\n these changes?',
                                confirmText: 'Save',
                                onConfirmPress: () {
                                  Get.back();
                                  // controller.authService.signOut();
                                },
                                isDismissible: true);
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ))),
          ),
        ));
  }
}
