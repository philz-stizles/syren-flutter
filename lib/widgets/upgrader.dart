import 'dart:io';

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class AppUpgrader extends StatelessWidget {
  const AppUpgrader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
        upgrader: Upgrader(
            // countryCode: 'NG',
            // debugLogging: true,
            shouldPopScope: () => true,
            // debugDisplayAlways: true,
            canDismissDialog: false,
            durationUntilAlertAgain: const Duration(days: 1),
            dialogStyle: (Platform.isIOS)
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material),
        child: child);
  }
}
