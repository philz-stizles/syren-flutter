import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'medical_record_edit_controller.dart';

class MedicalRecordEditView extends GetView<MedicalRecordEditController> {
  MedicalRecordEditView({super.key});
  static const String routeName = "/medical-record-edit";
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
                      options: controller.alleries,
                      onChanged: (String? val) {},
                      dropdownValue: controller.hasAllergiesDropdown.value,
                    ),
                    AppTextField(
                      labelText: 'If yes, state it',
                      hintText: 'Enter your allergies',
                      editingCtrl: controller.allergiesCtrl,
                      validationText: 'Please provide allergy details',
                    ),
                    AppTextField(
                      labelText: 'What medications do you take daily?',
                      hintText: 'Enter medications',
                      editingCtrl: controller.medicationsCtrl,
                      validationText: 'Please provide medication details',
                    ),
                    DropdownSelectField(
                      labelText: 'Do you have any medical conditions',
                      options: controller.conditions,
                      onChanged: (String? val) {},
                      dropdownValue: controller.hasConditionsDropdown.value,
                    ),
                    AppTextField(
                      labelText: 'If yes, state it',
                      hintText: 'Enter your conditions',
                      editingCtrl: controller.conditionsCtrl,
                      validationText: 'Please provide condition details',
                    ),
                    DropdownSelectField(
                      labelText: 'What is your Genotype?',
                      options: controller.genoTypes,
                      onChanged: (String? val) {
                        controller.genoTypeCtrl.text = val!;
                        controller.genoTypeDropdown.value = val;
                      },
                      dropdownValue: controller.genoTypeDropdown.value,
                    ),
                    DropdownSelectField(
                      labelText: 'What is your Blood Group?',
                      options: controller.bloodGroups,
                      onChanged: (String? val) {
                        controller.bloodGroupCtrl.text = val!;
                        controller.bloodGroupDropdown.value = val;
                      },
                      dropdownValue: controller.bloodGroupDropdown.value,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        title: 'Save Changes',
                        disabled: controller.isLoading.value,
                        loading: controller.isLoading.value,
                        press: () async {
                          if (signUpMedicalsFormKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            UIConfig.showConfirmBottomSheet(
                                icon: Icons.edit,
                                promptText:
                                    'Are sure you want to save\n these changes?',
                                confirmText: 'Save',
                                onConfirmPress: () async {
                                  Get.back();
                                  await controller.saveMedRecords();
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
