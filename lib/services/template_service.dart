import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TemplateService extends GetxService {
  // Future<TemplateService> init() async {
  //   return this;
  // }

  String readTemplate(String location) {
    var file = File(location);

    // get file location
    if (kDebugMode) {
      print('File path: ${file.path}');
      // get absolute path
      print('File absolute path: ${file.absolute.path}');
      // get file size
      print('File size: ${file.lengthSync()} bytes');
      // get last modified time
      print('Last modified: ${file.lastModifiedSync()}');
    }

    String fileStringContent = file.readAsStringSync();

    return fileStringContent;
  }
}
