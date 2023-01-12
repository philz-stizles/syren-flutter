import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'vitals_controller.dart';
import 'blood_pressure/blood_pressure_view.dart';
import 'blood_sugar/blood_sugar_view.dart';

class VitalsView extends GetView<VitalsController> {
  const VitalsView({super.key});
  static String routeName = "/vitals";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Vitals'),
      ),
      body: Padding(
        padding: defaultScreenPadding,
        child: Column(
          children: [
            const JumbotronCard(
                image: 'assets/images/medication-reminder.jpg',
                caption:
                    'With Syren, You’re sure to have\n stable blood vitals'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 450,
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.90,
                    children: [
                      ImageCaptionCard(
                          title: 'Blood Pressure',
                          imageLocation: 'assets/images/consultant.jpg',
                          icon: Icons.medical_information_outlined,
                          tap: () => Get.toNamed(BloodPressureView.routeName)),
                      ImageCaptionCard(
                          title: 'Blood Sugar',
                          imageLocation: 'assets/images/consultant.jpg',
                          icon: Icons.medical_information,
                          tap: () => Get.toNamed(BloodSugarView.routeName)),
                    ])),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: 0,
          onTap: ((value) {
            // Get.to(SettingsView());
          })),
    );
  }
}
