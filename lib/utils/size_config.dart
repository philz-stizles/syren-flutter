import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    // _mediaQueryData = MediaQuery.of(context);
    screenWidth = Get.mediaQuery.size.width; // _mediaQueryData.size.width;
    screenHeight = Get.mediaQuery.size.height; //  _mediaQueryData.size.height;
    orientation = Get.mediaQuery.orientation; // _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
