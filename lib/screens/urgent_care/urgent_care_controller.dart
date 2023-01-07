import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrgentCareController extends GetxController {
  final numberCtrl = TextEditingController();

  @override
  void onInit() {
    numberCtrl.text = "085921191121";
    super.onInit();
  }

  makingPhoneCall() async {
    var url = Uri.parse("tel:9776765434");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  callNumber() async {
    await FlutterPhoneDirectCaller.callNumber(numberCtrl.text);
  }
}

class UrgentCareBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UrgentCareController());
  }
}