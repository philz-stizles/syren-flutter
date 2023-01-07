import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syren/pages.dart';
import 'package:syren/initial_binding.dart';
import 'package:syren/screens/home.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/utils/themes.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBinding(),
        title: 'Syren',
        theme: theme(),
        home: const Home(),
        // initialRoute: '/signin',
        getPages: getPages());
  }
}
