import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syren/screens/auth/signin/signin_view.dart';
import 'package:syren/services/services.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  var authSrv = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
            child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(children: [
        DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Palette.primary),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                const CircleAvatar(),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Theophilus',
                      style: TextStyle(color: Palette.white),
                    ),
                    Text('User ID', style: TextStyle(color: Palette.white))
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: Palette.secondary,
          ),
          // contentPadding: const EdgeInsets.symmetric(vertical: 0),
          title: const Text('Profile'),
          onTap: () => {}, // Remember to use
          // pushReplacementNamed() so you dont keep pushing screens on the stack(PERFORMANCE!!!)
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.people,
            color: Palette.secondary,
          ),
          // contentPadding: const EdgeInsets.symmetric(vertical: 0),
          title: const Text('Next of Kin'),
          onTap: () => {}, // Remember to use
          // pushReplacementNamed() so you dont keep pushing screens on the stack(PERFORMANCE!!!)
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.calendar_month),
          title: const Text('Appointments'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.medication),
          title: const Text('Prescriptions'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Vitals'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
        const SizedBox(
          height: 30,
        ),
        PrimaryButton(
            title: 'Sign Out',
            press: () async {
              await authSrv.signOut();
              Get.offAllNamed(SignInView.routeName);
            })
      ]),
    )));
  }
}
