import 'package:flutter/material.dart';
import 'package:syren/utils/palette.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('MENU'),
          automaticallyImplyLeading:
              false, // This means a back button should not be added
          // to the Appbar, since we are using it in the Drawer
        ),
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
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
      ]),
    );
  }
}
