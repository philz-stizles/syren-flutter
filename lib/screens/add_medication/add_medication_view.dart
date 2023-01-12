import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/data.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'add_medication_controller.dart';

class AddMedicationView extends GetView<AddMedicationController> {
  AddMedicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Medications'),
      ),
      body: Padding(
        padding: defaultScreenPadding,
        child: Column(
          children: [
            const RadioButtonField(
                labelText: 'Set duration for getting drugs',
                options: ['Weekly', 'Monthly']),
            const Divider(
              height: 0,
            ),
            const SizedBox(
              height: 15,
            ),
            const Header(title: 'List of drugs for recurrent uses'),
            Expanded(
                child: ListView.builder(
              itemCount: drugsData.length,
              itemBuilder: (context, index) {
                var item = drugsData[index];
                return MedicationCard(
                    imageLocation: item.imageLocation,
                    title: item.title,
                    pills: item.pills,
                    time: item.time,
                    daysLeft: item.daysLeft,
                    when: item.when);
              },
            )),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
                title: 'Add Medication',
                // loading: controller.isLoadingSignIn.value,
                press: () async {
                  // await controller.signIn();
                }),
          ],
        ),
      ),
      bottomNavigationBar:
          AppBottomNavigationBar(currentIndex: 1, onTap: ((value) {})),
    );
  }
}
