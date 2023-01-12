import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceService extends GetxService {
  // final _storage = Get.find<StorageService>();
  final _deviceInfoPlugin = DeviceInfoPlugin();
  var deviceId = "".obs;
  var deviceName = "".obs;
  var appId = "".obs;

  Future<DeviceService> init() async {
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;

      deviceId.value = androidInfo.id;
      deviceName.value = androidInfo.brand;
      appId.value = 'com.ng.syren.android';
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      // deviceId.value = iosInfo.identifierForVendor! + iosInfo.utsname.machine!;
      deviceId.value = iosInfo.identifierForVendor!;
      deviceName.value = iosInfo.name!;
      appId.value = 'com.ng.syren.ios';
    } else if (GetPlatform.isDesktop) {
      WebBrowserInfo webBrowserInfo = await _deviceInfoPlugin.webBrowserInfo;

      deviceId.value = webBrowserInfo.userAgent! + webBrowserInfo.vendor!;
      deviceName.value = webBrowserInfo.userAgent!;
      appId.value = 'com.ng.syren.web';
    }

    // await _storage.write("inv-deviceId", deviceId.value);
    // await _storage.write("inv-deviceName", deviceId.value);
    // await _storage.write("inv-appId", appId.value);

    debugPrint('Init Device Service');

    return this;
  }

  // String getDeviceId() {
  //   return StorageService.read("inv-deviceId");
  // }

  // String? getDeviceName() {
  //   return StorageService.read("inv-deviceName");
  // }

  // String? getAppId() {
  //   return StorageService.read("inv-appId");
  // }
}
