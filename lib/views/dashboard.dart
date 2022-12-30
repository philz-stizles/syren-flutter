import 'package:flutter/material.dart';
import 'package:syren/utils/palette.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../utils/enums.dart';
import '../widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.medical_services),
            SizedBox(
              width: 5,
            ),
            Text('Syren')
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined))
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: defaultScreenPadding,
        child: Column(
          children: [
            SizedBox(
                height: 450,
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.90,
                    children: const [
                      ImageCaptionCard(
                        title: 'Vitals',
                        description:
                            'Get on top of your health today by checking your vitals',
                        imageLocation: 'assets/images/food-bank-initiative.jpg',
                        icon: Icons.area_chart,
                      ),
                      ImageCaptionCard(
                        title: 'Schedule Care',
                        description:
                            'Schedule your daily plans with consultants',
                        imageLocation: 'assets/images/consultant.jpg',
                        icon: Icons.calendar_month_outlined,
                      ),
                      ImageCaptionCard(
                        title: 'Purchase\n Medications',
                        description:
                            'Get prescribed medications easily at affordable prices',
                        imageLocation: 'assets/images/medication.jpg',
                        icon: Icons.medication,
                      ),
                      ImageCaptionCard(
                        title: 'Urgent Care\n(Panic Button)',
                        description:
                            'Any urgent issue? Call on our attention, we\'re here to help you.',
                        imageLocation: 'assets/images/siren.jpg',
                        icon: Icons.emergency_outlined,
                      ),
                    ])),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Palette.secondary, spreadRadius: 1),
                ],
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/consultant.jpg',
                        width: Get.width * 0.24,
                        height: 110,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'How are you feeling? Schedule an appointment with us today',
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrimaryButton(
                          title: 'Schedule',
                          press: () {},
                          expanded: false,
                          size: ButtonSize.small,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
