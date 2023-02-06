import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syren/utils/palette.dart';

class ImageService extends GetxService {
  // Observables.
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var croppedImagePath = ''.obs;
  var croppedImageSize = ''.obs;
  var compressedImagePath = ''.obs;
  var compressedImageSize = ''.obs;

  Future<ImageService> init() async {
    return this;
  }

  Future<File?> crop(XFile pickedImage) async {
    selectedImagePath.value = pickedImage.path;
    var selectedFile = File(selectedImagePath.value);
    selectedImageSize.value =
        '${(selectedFile.lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb';

    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: selectedImagePath.value,
      maxWidth: 512,
      maxHeight: 512,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Palette.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedImage != null) {
      croppedImagePath.value = croppedImage.path;
      var croppedFile = File(croppedImagePath.value);
      croppedImageSize.value =
          '${(croppedFile.lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb';
      return croppedFile;
    } else {
      return null;
    }
  }

  // 1. compress file and get Uint8List
  Future<Uint8List?> compressFileAndGetList(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );

    if (kDebugMode) {
      print(result?.length);
      print(file.lengthSync());
    }
    return result;
  }

  // 2. compress file and get file.
  Future<File?> compressAndGetFile(File file) async {
    Directory tempDir = Directory.systemTemp;
    String targetPath = '${tempDir.absolute.path}/temp.jpg';
    File? compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
    );

    if (compressedFile != null) {
      compressedImagePath.value = compressedFile.path;

      compressedImageSize.value =
          '${(compressedFile.lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb';
    }

    return compressedFile;
  }

  // 3. compress asset and get Uint8List.
  Future<Uint8List?> compressAssetAndGetList(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );

    return list;
  }

  // 4. compress Uint8List and get another Uint8List.
  Future<Uint8List> compressListAndGetList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );

    if (kDebugMode) {
      print(list.length);
      print(result.length);
    }
    return result;
  }
}
