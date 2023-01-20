import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/palette.dart';

class SuccessView extends StatelessWidget {
  const SuccessView(
      {super.key,
      required this.message,
      required this.title,
      required this.backToPage});
  static const String routeName = '/success';
  final String title;
  final String message;
  final String backToPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: (() => Get.offNamed(backToPage)),
                icon: const Icon(Icons.arrow_back)),
            title: Text(title)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 80,
                color: Palette.primary,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                message,
                maxLines: 2,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
