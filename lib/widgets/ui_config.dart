import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

class UIConfig {
  static showConfirmBottomSheet(
      {required IconData icon,
      required String promptText,
      String cancelText = 'Cancel',
      String confirmText = 'Confirm',
      required VoidCallback onConfirmPress,
      bool isDismissible = true}) async {
    Get.bottomSheet(
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 30.0, 20, 20),
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 30,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    promptText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: PrimaryButton(
                              outlined: true,
                              title: cancelText,
                              press: () {
                                Get.back();
                              })),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: PrimaryButton(
                              title: confirmText, press: onConfirmPress))
                    ],
                  )
                ],
              ))
        ],
      ),
      backgroundColor: Colors.white,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: isDismissible,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero),
      ),
    );
  }

  static showBottomSheet(Widget child, {isDismissible = true}) async {
    Get.bottomSheet(
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
              child: child)
        ],
      ),
      backgroundColor: Colors.white,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: isDismissible,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero),
      ),
    );
  }

  static navigateToNamedPage(String page, {arguments}) async {
    await Get.toNamed(page, arguments: arguments);
  }

  static navigateToPage(Widget page, {arguments}) async {
    await Get.to(() => page, arguments: arguments);
  }

  static navigateToReplacePage(Widget page, {arguments}) async {
    await Get.offAll(() => page, arguments: arguments);
  }

  static navigateToNamedReplacePage(String page, {arguments}) async {
    await Get.offAllNamed(page, arguments: arguments);
  }

  static void showSnackBar(
      {required String message,
      required backgroundColor,
      icon,
      position = SnackPosition.BOTTOM}) {
    Get.showSnackbar(GetSnackBar(
        message: message,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
        icon: icon,
        snackPosition: position));
  }

  static showResponseDialog(
      {icon,
      title,
      subtitle,
      isTwoBtn = false,
      btnTitle,
      onConfirm,
      barrierDismissible = true}) async {
    await Get.defaultDialog(
      barrierDismissible: barrierDismissible,
      titlePadding: const EdgeInsets.only(top: 10),
      title: '',
      content: Column(
        children: [
          icon ?? Container(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              // style: AppTextStyles.defaultStyle.copyWith(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w700,
              //     color: const Color.fromRGBO(70, 81, 116, 1)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              // style: AppTextStyles.defaultStyle.copyWith(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w400,
              //     color: const Color.fromRGBO(98, 107, 137, 1)),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
        ],
      ),
      cancel: isTwoBtn
          ? OutlinedButton(
              onPressed: () {
                Get.back();
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(100, 45),
              ),
              child: const Text(
                'Cancel',
                // style: AppTextStyles.defaultStyle.copyWith(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     color: const Color.fromRGBO(98, 107, 137, 1)),
              ),
            )
          : null,
      confirm: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ElevatedButton(
          onPressed: onConfirm ??
              () {
                Get.back();
              },
          style: ElevatedButton.styleFrom(
              fixedSize:
                  !isTwoBtn ? Size(Get.width * .5, 45) : const Size(100, 45)),
          child: Text(
            btnTitle ?? 'Confirm',
            // style: AppTextStyles.defaultStyle.copyWith(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w600,
            //     color: const Color.fromRGBO(231, 235, 236, 1)),
          ),
        ),
      ),
    );
  }

  static showModal(
      {icon,
      confirm,
      title,
      subtitle,
      content,
      isTwoBtn = false,
      btnTitle,
      onConfirm,
      barrierDismissible = true}) async {
    await Get.defaultDialog(
      radius: secondaryBorderRadius,
      barrierDismissible: barrierDismissible,
      contentPadding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
      titlePadding: const EdgeInsets.all(0),
      title: '',
      titleStyle: const TextStyle(height: 0),
      content: SingleChildScrollView(
        child: content,
      ),
    );
  }

  static showTermsOfServiceDialog(
      {icon, title, subtitle, isTwoBtn = false, btnTitle, onConfirm}) async {
    await Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10, bottom: 10),
      title: '',
      barrierDismissible: false,
      radius: 5,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                // style: AppTextStyles.defaultStyle.copyWith(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w700,
                //     color: const Color.fromRGBO(70, 81, 116, 1)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.justify,
                // style: AppTextStyles.defaultStyle.copyWith(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w400,
                //     color: const Color.fromRGBO(98, 107, 137, 1)),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
      cancel: isTwoBtn
          ? Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(100, 45),
                  ),
                  child: const Text(
                    'Decline',
                    // style: AppTextStyles.defaultStyle.copyWith(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w600,
                    //     color: const Color.fromRGBO(98, 107, 137, 1)),
                  ),
                ),
              ],
            )
          : null,
      confirm: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: onConfirm ??
                  () {
                    Get.back();
                  },
              style: ElevatedButton.styleFrom(
                  fixedSize: !isTwoBtn
                      ? Size(Get.width * .5, 45)
                      : const Size(100, 45)),
              child: Text(
                btnTitle ?? 'Confirm',
                // style: AppTextStyles.defaultStyle.copyWith(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //     color: const Color.fromRGBO(231, 235, 236, 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return SizedBox(
              height: height - 10, //This is the important part for you
              width: width - 10, //This is the important part for you
              child: const Center(
                child: Text("Hello SO"),
              ),
            );
          },
        ),
      ),
    );
  }
}
