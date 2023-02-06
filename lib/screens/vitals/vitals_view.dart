import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';
import 'blood_pressure/blood_pressure_view.dart';
import 'blood_sugar/blood_sugar_view.dart';

class VitalsScreen extends GetView<VitalsController> {
  const VitalsScreen({super.key});
  static const String routeName = "/vitals";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Vitals'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Column(
              children: [
                JumbotronCard(
                    image: 'assets/images/vitals.jpg',
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
                              imageLocation: 'assets/images/blood_pressure.jpg',
                              icon: Icons.bloodtype,
                              tap: () =>
                                  Get.toNamed(BloodPressureView.routeName)),
                          ImageCaptionCard(
                              title: 'Blood Sugar',
                              imageLocation: 'assets/images/blood_sugar.jpg',
                              icon: Icons.bloodtype_outlined,
                              tap: () => Get.toNamed(BloodSugarView.routeName)),
                        ])),
              ],
            ),
          ),
        )
        // bottomNavigationBar: AppBottomNavigationBar(
        //     currentIndex: 0,
        //     onTap: ((value) {
        //       // Get.to(SettingsView());
        //     })),
        );
  }
}

class VitalsController extends GetxController {}

class VitalsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VitalsController());
  }
}
