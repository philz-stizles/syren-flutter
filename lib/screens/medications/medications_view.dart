import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/medication_model.dart';
import 'package:syren/screens/add_medication/add_medication_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'medications_controller.dart';

class MedicationsView extends GetView<MedicationsController> {
  MedicationsView({super.key});
  static const String routeName = "/medications";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // persistentFooterButtons: [
      //   PrimaryButton(
      //       title: 'Add More Medication',
      //       // loading: controller.isLoadingSignIn.value,
      //       press: () async {
      //         // await controller.signIn();
      //       }),
      // ],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Medications'),
      ),
      body: Padding(
          padding: defaultScreenPadding,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: PrimaryButton(
                      outlined: controller.selectedPageIndex.value != 0,
                      title: 'Prescribed',
                      press: () {
                        controller.selectedPageIndex.value = 0;
                      },
                      expanded: false,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: PrimaryButton(
                      title: 'Random',
                      outlined: controller.selectedPageIndex.value != 1,
                      press: () {
                        controller.selectedPageIndex.value = 1;
                      },
                      expanded: false,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ...controller.selectedPageIndex.value == 0
                    ? _buildPrescribedMedication(controller.meds)
                    : _buildRandomMedication(controller.meds),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    title: 'Purchase Medication',
                    press: () {
                      Get.to(AddMedicationView());
                    }),
              ],
            ),
          )),
    );
  }

  List<Widget> _buildPrescribedMedication(List<MedicationModel> meds) {
    return [
      const Text(
        'Based on Doctors Prescription',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      meds.isEmpty
          ? const Text(
              'You have no prescribed medications listed here, Do well to make a purchase. ',
              style: TextStyle(fontSize: 12, color: Palette.grey),
            )
          : Expanded(
              child: ListView.builder(
              itemCount: meds.length,
              itemBuilder: (context, index) {
                var item = meds[index];
                return MedicationCard(
                    imageLocation: item.imageLocation,
                    title: item.title,
                    pills: item.pills,
                    time: item.time,
                    daysLeft: item.daysLeft,
                    when: item.when);
              },
            )),
    ];
  }

  List<Widget> _buildRandomMedication(List<MedicationModel> meds) {
    return [
      const Text(
        'Based on Random Purchase',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      meds.isEmpty
          ? const Text(
              'You Have no medications listed here, Do well to make a purchase.',
              style: TextStyle(fontSize: 12, color: Palette.grey),
            )
          : Expanded(
              child: Expanded(
                  child: ListView.builder(
                itemCount: meds.length,
                itemBuilder: (context, index) {
                  var item = meds[index];
                  return MedicationCard(
                      imageLocation: item.imageLocation,
                      title: item.title,
                      pills: item.pills,
                      time: item.time,
                      daysLeft: item.daysLeft,
                      when: item.when);
                },
              )),
            )
    ];
  }
}
