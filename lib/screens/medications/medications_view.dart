import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/data.dart';
import 'package:syren/screens/add_medication/add_medication_view.dart';
import 'package:syren/screens/settings/settings_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/navigation_bar.dart';
import 'package:syren/widgets/widgets.dart';

import 'medications_controller.dart';

class MedicationsView extends GetView<MedicationsController> {
  MedicationsView({super.key});
  static String routeName = "/medications";
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
        child: Column(
          children: [
            const Header(title: 'My Medications'),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: medicationsData.length,
              itemBuilder: (context, index) {
                var item = medicationsData[index];
                return MedicationCard(
                    imageLocation: item.imageLocation,
                    title: item.title,
                    pills: item.pills,
                    time: item.time,
                    daysLeft: item.daysLeft,
                    when: item.when);
              },
            )),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
                title: 'Add Medication',
                press: () {
                  Get.to(AddMedicationView());
                }),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: 1,
          onTap: ((value) {
            // Get.to(SettingsView());
          })),
    );
  }
}
