import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/screens/profile/medical_record_edit/medical_record_edit_view.dart';
import 'package:syren/screens/profile/profile_edit/profile_edit_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  static const String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: true, title: const Text('Profile')),
      body: Obx(() => SingleChildScrollView(
              child: Padding(
            padding: defaultScreenPadding,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Palette.primary,
                          child: CircleAvatar(
                            radius: 48,
                            child: Image.asset('assets/images/avatar.png'),
                          ),
                        ),
                        Positioned(
                            bottom: -5,
                            right: -5,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(0),
                              ),
                              child: const Icon(
                                Icons.photo_camera,
                                size: 20,
                                color: Palette.white,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('User ID: '),
                    const SizedBox(height: 20),
                  ],
                ),
                const SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: PrimaryButton(
                      outlined: !controller.isProfileSelected.value,
                      title: 'Profile',
                      press: (() {
                        controller.isProfileSelected.value = true;
                      }),
                      expanded: false,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: PrimaryButton(
                      title: 'Medical Records',
                      outlined: controller.isProfileSelected.value,
                      press: (() {
                        controller.isProfileSelected.value = false;
                      }),
                      expanded: false,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        controller.isProfileSelected.value
                            ? 'Personal Information'
                            : 'Medical Information',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    GestureDetector(
                      onTap: () => controller.isProfileSelected.value
                          ? Get.toNamed(ProfileEditView.routeName)
                          : Get.toNamed(MedicalRecordEditView.routeName),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Edit Info', style: TextStyle(fontSize: 12)),
                            SizedBox(width: 3),
                            Icon(Icons.edit, size: 18)
                          ]),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ...controller.isProfileSelected.value
                    ? _buildProfile(controller.userCtrl.user)
                    : _buildMedicalRecords(controller.userCtrl.user),
                const SizedBox(
                  height: 10,
                ),
                TextIconButton(
                  leadingIcon: Icons.stream,
                  label: 'Switch account',
                  onPress: () {},
                ),
                TextIconButton(
                  leadingIcon: Icons.logout,
                  label: logoutText,
                  onPress: () {
                    UIConfig.showConfirmBottomSheet(
                        icon: Icons.logout,
                        promptText:
                            'Are sure you want to sign out\n from this account?',
                        confirmText: 'Yes, sign out',
                        onConfirmPress: () async {
                          await controller.signOut();
                        },
                        isDismissible: true);
                  },
                )
              ],
            ),
          ))),
    );
  }

  List<Widget> _buildProfile(UserModel? user) {
    return [
      _buildInfoItemWidget(name: 'Name', value: user?.name),
      _buildInfoItemWidget(name: 'Date of Birth', value: user?.dob),
      _buildInfoItemWidget(name: 'Sex', value: user?.gender),
      _buildInfoItemWidget(name: 'Religion', value: user?.religion),
      _buildInfoItemWidget(name: 'Contact', value: user?.phone),
      _buildInfoItemWidget(name: 'Email Address', value: user?.email),
    ];
  }

  List<Widget> _buildMedicalRecords(UserModel? user) {
    return [
      _buildInfoItemWidget(
          name: 'Has allergies',
          value: user?.hasAllergies != null && user?.hasAllergies == true
              ? 'Yes'
              : 'No'),
      _buildInfoItemWidget(name: 'Allergies', value: user?.allergies),
      _buildInfoItemWidget(name: 'Medication', value: user?.medications),
      _buildInfoItemWidget(
          name: 'Has medical conditions',
          value: user?.hasMedicalConditions != null &&
                  user?.hasMedicalConditions == true
              ? 'Yes'
              : 'No'),
      _buildInfoItemWidget(
          name: 'Medical Conditions', value: user?.medicalConditions),
      _buildInfoItemWidget(name: 'Genotype', value: user?.genoType),
      _buildInfoItemWidget(name: 'Blood Group', value: user?.bloodGroup),
    ];
  }

  Widget _buildInfoItemWidget({required String name, String? value}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Palette.secondary, width: 1),
        borderRadius: BorderRadius.circular(secondaryBorderRadius),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text('$value', style: const TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}
