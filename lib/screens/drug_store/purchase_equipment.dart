import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/data.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class PurchaseEquipmentView extends GetView<PurchaseEquipmentController> {
  const PurchaseEquipmentView({super.key});
  static const String routeName = "/purchase-equipment";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dimWhite,
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('Drug Store')),
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
                  height: 20,
                ),
                const Text(
                  'Available Medications',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                ...controller.selectedPageIndex.value == 0
                    ? _buildPrescribedEquipments(controller.equipments)
                    : _buildRandomEquipments(controller.equipments),
              ],
            ),
          )),
    );
  }

  List<Widget> _buildPrescribedEquipments(List<DrugProductModel> equipments) {
    return [
      Expanded(
          child: ListView.builder(
        itemCount: equipments.length,
        itemBuilder: (context, index) {
          var item = equipments[index];
          return DrugProductCard(
            imageLocation: item.imageLocation,
            name: item.name,
            description: item.description,
            prescribedBy: item.prescribedBy,
            price: item.price.toString(),
            onTap: () =>
                Get.toNamed(PurchaseDetailView.routeName, arguments: item),
          );
        },
      ))
    ];
  }

  List<Widget> _buildRandomEquipments(List<DrugProductModel> equipments) {
    return [
      Expanded(
          child: ListView.builder(
        itemCount: equipments.length,
        itemBuilder: (context, index) {
          var item = equipments[index];
          return DrugProductCard(
            imageLocation: item.imageLocation,
            name: item.name,
            description: item.category,
            prescribedBy: item.prescribedBy,
            price: item.price.toString(),
            onTap: () =>
                Get.toNamed(PurchaseDetailView.routeName, arguments: item),
          );
        },
      ))
    ];
  }
}

class PurchaseEquipmentController extends GetxController {
  // Observables.
  RxInt selectedPageIndex = 0.obs;

  // Data.
  List<DrugProductModel> equipments = equipmentProductsData;
}

class PurchaseEquipmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseEquipmentController());
  }
}
