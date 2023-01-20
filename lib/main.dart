import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syren/controllers/controllers.dart';
import 'package:syren/pages.dart';
import 'package:syren/screens/home.dart';
import 'package:syren/services/services.dart';
import 'package:syren/utils/themes.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  Get.put(MainController(), permanent: true);
  await Get.putAsync(() => EnvironmentService().init());
  await Get.putAsync(() => DeviceService().init());
  await Get.putAsync(() => AppService().init());
  // await Get.putAsync(() => ThemeService().init());
  // await Get.putAsync(() => BiometricService().init());
  await Get.putAsync(() => EmailService().init());
  await Get.putAsync(() => LocalNotificationService().init());
  await Get.putAsync(() => NotificationService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Syren',
        themeMode: ThemeService().theme,
        theme: theme(),
        darkTheme: darkTheme(),
        home: const Home(),
        // initialRoute: '/signin',
        getPages: getPages());
  }
}
