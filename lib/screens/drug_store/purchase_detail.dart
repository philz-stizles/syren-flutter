import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/drug_product_model.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class PurchaseDetailView extends GetView<PurchaseDetailController> {
  PurchaseDetailView({super.key});
  static const String routeName = "/purchase-detail";

  final item = Get.arguments as DrugProductModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dimWhite,
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('Drug Store')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Obx((() => Column(
                    children: [
                      DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(color: Palette.grey),
                              borderRadius:
                                  BorderRadius.circular(mediumBorderRadius)),
                          child: SizedBox(
                            width: 364,
                            height: 280,
                            child: Image.asset(item.imageLocation!,
                                scale: 0.8,
                                filterQuality: FilterQuality.medium,
                                fit: BoxFit.contain),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Wrap(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.label),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 16,
                                    color: item.prescribedBy == null
                                        ? null
                                        : Palette.primary,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    'Prescribed',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Palette.label),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () => controller.tabIndex.value = 0,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 2,
                                              color:
                                                  controller.tabIndex.value == 0
                                                      ? Palette.grey
                                                      : Colors.transparent))),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                        color: Palette.label,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ))),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                              onTap: () => controller.tabIndex.value = 1,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color:
                                                controller.tabIndex.value == 1
                                                    ? Palette.grey
                                                    : Colors.transparent))),
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Reviews',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Palette.label,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        item.description ?? '',
                        textAlign: TextAlign.justify,
                        style:
                            const TextStyle(color: Palette.grey, height: 1.8),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )))),
          DecoratedBox(
              decoration: const BoxDecoration(color: Palette.lightGrey),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Palette.label),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () => controller.removeFromQuantity(),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(mediumBorderRadius)),
                                border: Border.all(color: Palette.midGrey)),
                            child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(Icons.remove)),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Obx((() => SizedBox(
                            width: 25,
                            height: 30,
                            child: Center(
                              child: Text(
                                '${controller.quantity.value}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.label),
                              ),
                            )))),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () => controller.addToQuantity(),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(mediumBorderRadius)),
                                  border: Border.all(color: Palette.midGrey)),
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(Icons.add),
                              )),
                        )
                      ],
                    ),
                    Text(
                      '\$${item.price}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Palette.label),
                    )
                  ],
                ),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      child: PrimaryButton(
                          outlined: true, title: 'Buy Now', press: () {})),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child:
                          PrimaryButton(title: 'Add to  Cart', press: () {})),
                ],
              ))
        ],
      )),
    );
  }
}

class PurchaseDetailController extends GetxController {
  // Observables.
  RxInt tabIndex = 0.obs;
  RxInt quantity = 0.obs;

  void addToQuantity() {
    quantity.value += 1;
  }

  void removeFromQuantity() {
    if (quantity.value > 0) {
      quantity.value -= 1;
    }
  }
}

class PurchaseDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseDetailController());
  }
}
