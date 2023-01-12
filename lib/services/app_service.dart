import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppService extends GetxService {
  PackageInfo packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown');

  Future<AppService> init() async {
    final info = await PackageInfo.fromPlatform();

    packageInfo = info;

    return this;
  }
}
