import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/schedule_care/clinic_appointment/clinic_appointment_view.dart';
import 'package:syren/screens/schedule_care/home_visit/home_visit_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'schedule_care_controller.dart';

class ScheduleCareView extends GetView<ScheduleCareController> {
  const ScheduleCareView({super.key});
  static String routeName = "/schedule-care";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Schedule Care'),
      ),
      body: Padding(
          padding: defaultScreenPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const JumbotronCard(
                    image: 'assets/images/medication-reminder.jpg',
                    caption:
                        'With Syren, You get to Schedule\n care at ease with consultants'),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 450,
                    child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.90,
                        children: [
                          ImageCaptionCard(
                              title: 'Home Visit',
                              imageLocation: 'assets/images/consultant.jpg',
                              icon: Icons.medical_information_outlined,
                              tap: () => Get.toNamed(HomeVisitView.routeName)),
                          ImageCaptionCard(
                              title: 'Clinic\n Appointment',
                              imageLocation: 'assets/images/consultant.jpg',
                              icon: Icons.calendar_today_outlined,
                              tap: () =>
                                  Get.toNamed(ClinicAppointmentView.routeName)),
                          ImageCaptionCard(
                              title: 'Ambulance\n Services',
                              imageLocation: 'assets/images/consultant.jpg',
                              icon: Icons.medical_information_outlined,
                              tap: () => Get.toNamed(HomeVisitView.routeName)),
                          ImageCaptionCard(
                              title: 'Diagnostics\n Center Appointment',
                              imageLocation: 'assets/images/consultant.jpg',
                              icon: Icons.local_hospital_outlined,
                              tap: () =>
                                  Get.toNamed(ClinicAppointmentView.routeName)),
                        ])),
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
}
