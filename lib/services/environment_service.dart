import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class EnvironmentService extends GetxService {
  Future<EnvironmentService> init() async {
    if (kReleaseMode) {
      await dotenv.load(fileName: ".env.production");
    } else {
      await dotenv.load(fileName: ".env.development");
    }

    debugPrint('Init Environment Service');
    return this;
  }
}
