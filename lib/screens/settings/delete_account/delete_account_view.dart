import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});
  static String routeName = '/delete-account';

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
            Row(
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
                  press: () {
                    // controller.selectedPageIndex.value = 1;
                  },
                  expanded: false,
                ))
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: 3,
          onTap: ((value) {
            // Get.to(SettingsView());
          })),
    );
  }
}
