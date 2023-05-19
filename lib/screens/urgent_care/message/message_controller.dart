import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/models/models.dart';
import 'package:syren/services/services.dart';

class MessageController extends GetxController {
  // Services.
  var chatSrv = Get.put(ChatService());
  var userCtrl = Get.put(UserService());

  // Observable.
  var chatMessage = ''.obs;

  Future<void> sendMessage() async {
    FocusManager.instance.primaryFocus?.unfocus();

    var isSuccess = await chatSrv.add(ChatModel(
        message: chatMessage.value.trim(),
        createdAt: Timestamp.now(),
        createdBy: ''));

    if (isSuccess) {
      chatMessage.value = '';
    }
  }
}

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageController());
  }
}
