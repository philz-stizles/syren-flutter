import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/enums.dart';
import 'package:syren/widgets/widgets.dart';

import 'schedule_care_controller.dart';

class ScheduleCareView extends GetView<ScheduleCareController> {
  ScheduleCareView({super.key});
  static String routeName = "/Schedule-care";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Schedule Care')),
        body: SingleChildScrollView(
            child: Padding(
          padding: defaultScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RadioButtonField(
                  direction: RadioButtonDirection.vertical,
                  labelText: 'Describe patient\'s current condition',
                  options: [
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
                children: [
                  const Icon(Icons.car_rental),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
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
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  PrimaryButton(
                    outlined: true,
                    title: 'Call',
                    press: () => controller.callNumber(),
                    expanded: false,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  PrimaryButton(
                    title: 'Message',
                    press: () {},
                    expanded: false,
                  )
                ],
              )
            ],
          ),
        )));
  }
}
