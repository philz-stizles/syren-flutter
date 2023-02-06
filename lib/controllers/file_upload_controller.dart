import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FileUploadController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;

  final Rxn<File?> _photo = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _photo.value = File(pickedFile.path);
      uploadFile();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _photo.value = File(pickedFile.path);
      uploadFile();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future uploadFile() async {
    if (_photo.value == null) return;
    final fileName = basename(_photo.value!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_photo.value!);
    } catch (e) {
      debugPrint('error occured');
    }
  }
}
