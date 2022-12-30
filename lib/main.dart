import 'package:flutter/material.dart';
import 'package:syren/utils/themes.dart';
import 'package:syren/views/sign_up.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Syren',
      theme: theme(),
      home: const SignUpScreen(),
    );
  }
}
