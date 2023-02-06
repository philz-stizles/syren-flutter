import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/services/services.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class DeleteAccountView extends StatelessWidget {
  DeleteAccountView({super.key});
  static const String routeName = '/delete-account';

  final deleteAccountCtrl = Get.put(DeleteAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('Delete Account')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.delete_outlined,
              size: 80,
              color: Palette.primary,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Are you sure you want to delete your account?\nThis action cannot be undone.',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                      child: PrimaryButton(
                    outlined: true,
                    title: 'Cancel',
                    press: () {
                      Get.back();
                    },
                    expanded: false,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: PrimaryButton(
                    title: 'Delete Account',
                    loading: deleteAccountCtrl.isLoading.value,
                    disabled: deleteAccountCtrl.isLoading.value,
                    press: () async => await deleteAccountCtrl.deleteAccount(),
                    expanded: false,
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DeleteAccountController extends GetxController {
  // Services.
  var authSrv = Get.put(AuthService());
  var userSrv = Get.put(UserService());

  // Observables.
  var isLoading = false.obs;

  Future<void> deleteAccount() async {
    try {
      isLoading(true);
      await authSrv.deleteAccount();
      await userSrv.deleteAccount();
      Get.offAllNamed(SignUpView.routeName);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoading(false);
    }
  }
}
