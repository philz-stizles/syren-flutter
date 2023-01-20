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
  static const String routeName = '/feedback';
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('Feedback')),
      body: SingleChildScrollView(
        child: Padding(
            padding: defaultScreenPadding,
            child: Obx((() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Kindly rate the App',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Palette.secondary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RatingBar.builder(
                        itemSize: 30,
                        initialRating: controller.rating.value,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.only(right: 8),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (double rating) {
                          controller.rating.value = rating;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RadioButtonField(
                      direction: RadioButtonDirection.vertical,
                      labelText:
                          'Which category will you like to give feedback?',
                      options: controller.feedbackCategories,
                      onChanged: (value) => controller.category.value = value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      maxLines: 5,
                      labelText: 'Send in your feedback here',
                      hintText: 'Send your feedback',
                      editingCtrl: controller.messageCtrl,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    PrimaryButton(
                        disabled: controller.isSavingFeedback.value,
                        loading: controller.isSavingFeedback.value,
                        title: 'Submit',
                        press: () async {
                          await controller.saveFeedback();
                        }),
                  ],
                )))),
      ),
      // bottomNavigationBar: AppBottomNavigationBar(
      //     currentIndex: 3,
      //     onTap: ((value) {
      //       // Get.to(SettingsView());
      //     })),
    );
  }
}
