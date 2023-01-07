import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/data.dart';

class SplashController extends GetxController {
  SplashController({required this.context});
  // Data.
  late BuildContext context;
  List<Map<String, dynamic>> splashData = splashScreenData;

  // Observables.
  var currentPage = 0.obs;
  @override
  void onInit() {
    splashData = splashData.map((e) {
      var image = Image.asset(e['image'],
          width: double.infinity,
          height: double.infinity,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover);

      return {...e, 'image': image};
    }).toList();

    for (var element in splashData) {
      precacheImage(element['image'].image, context);
    }

    super.onInit();
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    for (var element in splashData) {
      precacheImage(element['image'].image, context);
    }
    super.update(ids, condition);
  }
}
