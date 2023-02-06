import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:syren/controllers/user_controller.dart';
import 'package:syren/screens/auth/signin/signin_view.dart';
import 'package:syren/screens/auth/signup/signup_view.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';

class ProfileController extends GetxController {
  // Services.
  var authService = Get.find<AuthService>();
  var imageService = Get.put(ImageService());
  var userService = Get.put(UserService());

  // Services.
  var userCtrl = Get.put(UserController());

  // Observables
  var isProfileSelected = true.obs;
  var isShowingAccounts = false.obs;
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    userCtrl.user = await userService.getUser();
    super.onInit();
  }

  Future<void> selectUploadOption() async {
    try {
      UIConfig.showBottomSheet(Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
              title: 'Select a picture',
              icon: Icons.file_upload_outlined,
              press: () => uploadImage(source: ImageSource.gallery)),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
              title: 'Use Camera',
              icon: Icons.photo_camera,
              outlined: true,
              press: () => uploadImage(source: ImageSource.camera))
        ],
      ));
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {}
  }

  Future<void> uploadImage({required ImageSource source}) async {
    try {
      final firebaseStorage = FirebaseStorage.instance;
      final imagePicker = ImagePicker();
      XFile? pickedImage = await imagePicker.pickImage(source: source);

      if (pickedImage != null) {
        isLoading(true);

        Get.back();

        // Crop.
        var croppedFile = await imageService.crop(pickedImage);

        // Compress.
        if (croppedFile != null) {
          var compressedFile = await imageService.compressAndGetFile(
              croppedFile); //var file = File(pickedImage.path);
          if (compressedFile != null) {
            final destination = 'files/${basename(pickedImage.path)}';
            //Upload to Firebase
            var snapshot = await firebaseStorage
                .ref(destination)
                .child('images/imageName')
                .putFile(compressedFile);
            // .whenComplete(() => null);
            var downloadUrl = await snapshot.ref.getDownloadURL();
            await userService.update({'avatar': downloadUrl});
          }
        }
      } else {
        debugPrint('No Image Path Received');
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleAccounts() async {
    isShowingAccounts.value = !isShowingAccounts.value;
  }

  Future<void> signOut() async {
    await authService.signOut();
    Get.back();
    Get.toNamed(SignInView.routeName);
  }

  Future<void> addAccount() async {
    Get.toNamed(SignUpView.routeName,
        arguments: {'parent': userCtrl.user?.email});
  }
}

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
