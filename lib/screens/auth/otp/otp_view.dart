import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/utils/size_config.dart';
import 'package:syren/widgets/widgets.dart';

import 'otp_controller.dart';

class OtpView extends GetView<OtpController> {
  OtpView({super.key});
  static const String routeName = "/otp";
  final loginFormKey = GlobalKey<FormState>();
  var email = Get.arguments['email'];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Obx(() => Stack(children: [
          Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Image.asset(
                'assets/images/logo.png',
                scale: 1.2,
                fit: BoxFit.cover,
              ),
            ),
            body: SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.04),
                        const Text(
                          "OTP Verification",
                          style: headingStyle,
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'We sent your code to ',
                                style: const TextStyle(color: Palette.grey),
                                children: [
                              TextSpan(
                                  text: '$email',
                                  style:
                                      const TextStyle(color: Palette.primary))
                            ])),
                        OTPExpiryMessage(
                            content: "This code will expired in ",
                            time: controller
                                .getOTPExpiry(controller.duration.value),
                            format: ' minutes.'),
                        _buildOTPForm(context),
                        SizedBox(height: Get.height * 0.1),
                      ],
                    ),
                  )),
            ),
          ),
          if (controller.isLoadingGenerateOtp.value)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (controller.isLoadingGenerateOtp.value)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ]));
  }

  // Row _buildTimer() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       const Text("This code will expired in "),
  //       TweenAnimationBuilder(
  //         tween: Tween(begin: 30.0, end: 0.0),
  //         duration: const Duration(seconds: 30),
  //         builder: (_, dynamic value, child) => Text(
  //           "00:${value.toInt()}",
  //           style: const TextStyle(color: Palette.primary),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Form _buildOTPForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildOTPField(
                  controller: controller.pin1Ctrl,
                  autofocus: true,
                  onChanged: (value) =>
                      controller.nextField(value, controller.pin2FocusNode)),
              SizedBox(width: SizeConfig.screenWidth * 0.05),
              _buildOTPField(
                  controller: controller.pin2Ctrl,
                  node: controller.pin2FocusNode,
                  onChanged: (value) =>
                      controller.nextField(value, controller.pin3FocusNode)),
              SizedBox(width: SizeConfig.screenWidth * 0.05),
              _buildOTPField(
                  controller: controller.pin3Ctrl,
                  node: controller.pin3FocusNode,
                  onChanged: (value) =>
                      controller.nextField(value, controller.pin4FocusNode)),
              SizedBox(width: SizeConfig.screenWidth * 0.05),
              _buildOTPField(
                controller: controller.pin4Ctrl,
                node: controller.pin4FocusNode,
                onChanged: (value) {
                  if (value.length == 1) {
                    controller.nextField(value, controller.pin4FocusNode);
                    controller.pin4FocusNode!.unfocus();
                    // Then you need to check is the code is correct or not
                  }
                },
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          RichText(
              text: TextSpan(
                  text: 'Didn’t get code? ',
                  style: const TextStyle(color: Palette.grey),
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await controller.generateOTP(email: email);
                      },
                    text: 'Resend',
                    style: const TextStyle(color: Palette.primary))
              ])),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          PrimaryButton(
            title: "Verify Account",
            loading: controller.isLoadingValidateOtp.value,
            disabled: controller.isLoadingValidateOtp.value,
            press: () async {
              var code = controller.pin1Ctrl.text +
                  controller.pin2Ctrl.text +
                  controller.pin3Ctrl.text +
                  controller.pin4Ctrl.text;
              await controller.validateOTP(email: email, code: code);
            },
          )
        ],
      ),
    );
  }

  Widget _buildOTPField(
      {TextEditingController? controller,
      autofocus = false,
      FocusNode? node,
      void Function(String)? onChanged}) {
    return SizedBox(
      width: getProportionateScreenWidth(60),
      child: TextFormField(
        controller: controller,
        autofocus: autofocus,
        focusNode: node,
        obscureText: true,
        style: const TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: otpInputDecoration,
        onChanged: onChanged,
      ),
    );
  }
}
