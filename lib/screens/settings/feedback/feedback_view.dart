import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/enums.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  FeedbackView({super.key});
  static String routeName = '/feedback';
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true, title: const Text('Feedback')),
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultScreenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'kindly rate the App',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Palette.secondary),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                    itemSize: 30,
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RadioButtonField(
                    direction: RadioButtonDirection.vertical,
                    labelText: 'Which category will you like to give feedback?',
                    options: controller.feedbackCategories),
                AppTextField(
                  maxLines: 5,
                  labelText: 'Send in your feedback here',
                  hintText: 'Send your feedback',
                  editingCtrl: controller.confirmCtrl,
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                    title: 'Submit',
                    press: () async {
                      Get.back();
                    }),
              ],
            ),
          ),
        ));
  }
}
