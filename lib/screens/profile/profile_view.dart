import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/screens/profile/medical_record_edit/medical_record_edit_view.dart';
import 'package:syren/screens/profile/profile_edit/profile_edit_view.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  static String routeName = "/profile";
  var isProfileSelected = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dimWhite,
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
                      outlined: !isProfileSelected.value,
                      title: 'Profile',
                      press: (() {
                        isProfileSelected.value = true;
                      }),
                      expanded: false,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: PrimaryButton(
                      title: 'Medical Records',
                      outlined: isProfileSelected.value,
                      press: (() {
                        isProfileSelected.value = false;
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
                        isProfileSelected.value
                            ? 'Personal Information'
                            : 'Medical Information',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    GestureDetector(
                      onTap: () => isProfileSelected.value
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
                ...isProfileSelected.value
                    ? _buildProfile()
                    : _buildMedicalRecords(),
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
                        confirmText: 'Yes, sign out btch',
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

  List<Widget> _buildProfile() {
    return [
      _buildInfoItemWidget(name: 'Name', value: 'Theophilus Ighalo'),
      _buildInfoItemWidget(name: 'Date of Birth', value: 'September 10, 1996'),
      _buildInfoItemWidget(name: 'Sex', value: 'Male'),
      _buildInfoItemWidget(name: 'Religion', value: 'Christian'),
      _buildInfoItemWidget(name: 'Contact', value: '+234 802 347 6812'),
      _buildInfoItemWidget(name: 'Email Address', value: 't@gmail.com'),
    ];
  }

  List<Widget> _buildMedicalRecords() {
    return [
      _buildInfoItemWidget(name: 'Allergies', value: 'Nil'),
      _buildInfoItemWidget(name: 'Medication', value: 'Gelatamine'),
      _buildInfoItemWidget(name: 'Medical Conditions', value: 'Alzheimers'),
      _buildInfoItemWidget(name: 'Genotype', value: 'AS'),
      _buildInfoItemWidget(name: 'Blood Group', value: 'O+ Positive'),
      const SizedBox(
        height: 65,
      ),
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
