// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:syren/models/models.dart';
// import 'package:syren/services/services.dart';

// class ReminderController extends GetxController {
//   // Services.
//   final reminderSrv = Get.put(ReminderService());

//   // Observables.
//   RxList<ReminderModel> reminders = <ReminderModel>[].obs;

//   @override
//   Future<void> onReady() async {
//     debugPrint('Reminders onReady');
//     await getReminders();
//     super.onReady();
//   }

//   Future<void> getReminders() async {
//     try {
//       reminders.assignAll(await reminderSrv.query());
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   Future<void> insert(ReminderModel model) async {
//     await reminderSrv.insert(model);

//     await getReminders();
//   }

//   Future<void> clearAll() async {
//     var affectedRecords = await reminderSrv.deleteAll();
//     if (affectedRecords > 0) {
//       await getReminders();
//     }
//   }
// }
