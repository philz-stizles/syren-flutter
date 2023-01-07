import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class DrugStoreView extends GetView<DrugStoreController> {
  const DrugStoreView({super.key});
  static String routeName = "/drug-store";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dimWhite,
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text('Drug Store')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [],
              )),
          Container(
            decoration: const BoxDecoration(color: Palette.lightGrey),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
                const Text('\$5.90')
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      child: PrimaryButton(title: 'Buy Now', press: () {})),
                  const SizedBox(),
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

class DrugStoreController extends GetxController {}
