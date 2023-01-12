import 'package:flutter/material.dart';
import 'package:syren/screens/drug_store/drug_store.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/screens/vitals/vitals_controller.dart';
import 'package:syren/utils/palette.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  var isActive = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(ProfileView.routeName);
          },
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/images/avatar.png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              )),
        ),
        //       Container(
        //           width: 40,
        //           height: 40,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(8),
        //               image: DecorationImage(
        //                   fit: BoxFit.cover,
        //                   image: NetworkImage(homeCtrl
        //                       .appCtrl
        //                       .currentUserProfile
        //                       .value!
        //                       .data!
        //                       .profilePic!))),
        //           child: Container()),
        // ),
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
                    children: [
                      ImageCaptionCard(
                        title: 'Vitals',
                        description:
                            'Get on top of your health today by checking your vitals',
                        imageLocation: 'assets/images/food-bank-initiative.jpg',
                        icon: Icons.area_chart,
                        tap: () {
                          Get.to(VitalsView(), binding: VitalsBinding());
                        },
                      ),
                      ImageCaptionCard(
                        title: 'Schedule Care',
                        description:
                            'Schedule your daily plans with consultants',
                        imageLocation: 'assets/images/consultant.jpg',
                        icon: Icons.calendar_month_outlined,
                        tap: () {
                          Get.toNamed(ScheduleCareView.routeName);
                        },
                      ),
                      ImageCaptionCard(
                        title: 'Drug Store',
                        description:
                            'Get Prescribed medications easily at affordable prices, and Medical Equiments.',
                        imageLocation: 'assets/images/medication.jpg',
                        icon: Icons.medication,
                        tap: () {
                          Get.toNamed(DrugStoreView.routeName);
                        },
                      ),
                      ImageCaptionCard(
                          title: 'Urgent Care\n(Panic Button)',
                          description:
                              'Any urgent issue? Call on our attention, we\'re here to help you.',
                          imageLocation: 'assets/images/siren.jpg',
                          icon: Icons.emergency_outlined,
                          tap: () => Get.toNamed(UrgentCareView.routeName)),
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
      bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: 0,
          onTap: ((value) {
            // Get.to(SettingsView());
          })),
    );
  }

  Widget _buildMenuItem(
      {required String title, void Function()? onTap, required bool isActive}) {
    return GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(secondaryBorderRadius),
              color: isActive ? Palette.primary : Palette.white),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(title),
          ),
        ));
  }
}
