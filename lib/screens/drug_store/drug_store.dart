import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class DrugStoreView extends GetView<DrugStoreController> {
  const DrugStoreView({super.key});
  static const String routeName = "/drug-store";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dimWhite,
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('Drug Store')),
      body: Padding(
        padding: defaultScreenPadding,
        child: Column(
          children: [
            JumbotronCard(
                image: 'assets/images/vitals.jpg',
                caption:
                    'With Syren, you get the best medications and medical equipements to help you.'),
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
                          title: 'Purchase\n Medications',
                          imageLocation: 'assets/images/blood_pressure.jpg',
                          icon: Icons.bloodtype,
                          tap: () =>
                              Get.toNamed(PurchaseMedicationView.routeName)),
                      ImageCaptionCard(
                          title: 'Purchase\n Equipments',
                          imageLocation: 'assets/images/blood_sugar.jpg',
                          icon: Icons.medical_services,
                          tap: () =>
                              Get.toNamed(PurchaseEquipmentView.routeName)),
                    ])),
          ],
        ),
      ),
    );
  }
}

class DrugStoreController extends GetxController {}

class DrugStoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DrugStoreController());
  }
}
