import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/urgent_care/message/message_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/enums.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'urgent_care_controller.dart';

class UrgentCareView extends GetView<UrgentCareController> {
  UrgentCareView({super.key});
  static String routeName = "/urgent-care";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true, title: const Text('Urgent Care')),
        body: SingleChildScrollView(
            child: Padding(
          padding: defaultScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioButtonField(
                  direction: RadioButtonDirection.vertical,
                  labelText: 'Describe patient\'s current condition',
                  options: const [
                    'Currently not Breathing or Responding',
                    'Currently Breathing but in Distress',
                    'Others'
                  ]),
              const Text(
                'Get across to us here',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Palette.primary
                        // border: Border.all(width: 2, color: Colors.white)
                        ),
                    child: const Icon(
                      Icons.car_rental,
                      color: Palette.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Syren',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Give us a call or send us a message regarding your current situation',
                        // softWrap: false,
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      outlined: true,
                      title: 'Call',
                      icon: Icons.phone,
                      press: () => controller.callNumber(),
                      expanded: false,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: PrimaryButton(
                    title: 'Message',
                    icon: Icons.message,
                    press: () => Get.toNamed(MessageView.routeName),
                    expanded: false,
                  ))
                ],
              )
            ],
          ),
        )));
  }
}
