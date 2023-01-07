import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/signup/signup_view.dart';
import 'package:syren/screens/splash/splash_controller.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  static String routeName = "/splash-view";

  @override
  Widget build(BuildContext context) {
    var splashCtrl = Get.put(SplashController(context: context));
    return Scaffold(
      body: Obx(() => Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(defaultBorderRadius)),
                            child: splashCtrl
                                    .splashData[splashCtrl.currentPage.value]
                                ['image'],

                            // child: Image.asset(
                            //     splashCtrl.splashData[
                            //         splashCtrl.currentPage.value]['image'],
                            //     width: double.infinity,
                            //     height: double.infinity,
                            //     filterQuality: FilterQuality.high,
                            //     fit: BoxFit.cover)
                            // height: getProportionateScreenHeight(265),
                            // width: getProportionateScreenWidth(235),
                          ),
                          (splashCtrl.currentPage.value == 0)
                              ? const SizedBox()
                              : Positioned(
                                  top: 40,
                                  left: 10,
                                  child: IconButton(
                                    color: Palette.white,
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      if (splashCtrl.currentPage.value != 0) {
                                        splashCtrl.currentPage.value =
                                            splashCtrl.currentPage.value - 1;
                                      }
                                    },
                                  ))
                        ],
                      ))),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashCtrl.splashData.length,
                        (index) => buildDot(
                            index: index,
                            currentPage: splashCtrl.currentPage.value),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                        splashCtrl.splashData[splashCtrl.currentPage.value]
                            ['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        splashCtrl.splashData[splashCtrl.currentPage.value]
                            ['description'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.normal)),
                    const Spacer(),
                    PrimaryButton(
                        title: splashCtrl.currentPage.value ==
                                splashCtrl.splashData.length - 1
                            ? 'Get Started'
                            : 'Next',
                        press: () {
                          if (splashCtrl.currentPage.value ==
                              splashCtrl.splashData.length - 1) {
                            Get.offNamed(SignUpView.routeName);
                          } else {
                            splashCtrl.currentPage.value =
                                splashCtrl.currentPage.value + 1;
                          }
                          debugPrint(splashCtrl.currentPage.value.toString());
                        })
                  ],
                ),
              ))
            ],
          )),
    );
  }

  AnimatedContainer buildDot({required int index, required int currentPage}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Palette.primary : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
