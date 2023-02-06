import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:syren/models/models.dart';

class ReminderModel {
  int? id;
  String? title;
  String? note;
  String? body;
  String? date;
  late bool isRead;
  late bool isCompleted;
  Timestamp? timestamp;
  late Time time;
  NotificationInterval? interval;
  late NotificationType notificationType;

  ReminderModel(
      {this.id,
      this.title,
      this.note,
      this.body,
      this.date,
      this.timestamp,
      required this.time,
      this.isRead = false,
      this.isCompleted = false,
      this.interval,
      this.notificationType = NotificationType.defaultNotification});

  ReminderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    note = json['note'];
    date = json['date'];
    isRead = json['isRead'] != null && json['isRead'] == 1 ? true : false;
    isCompleted = json['iisCompleted'] != null && json['iisCompleted'] == 1
        ? true
        : false;
    timestamp = json['timestamp'];
    // time = json['time'];
    interval = json['interval'];
    notificationType = NotificationType.values
        .firstWhere((element) => element.name == json['notificationType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['note'] = note;
    data['body'] = body;
    data['date'] = date;
    data['isRead'] = isRead ? 1 : 0;
    data['isCompleted'] = isCompleted ? 1 : 0;
    data['timestamp'] = timestamp;
    data['time'] = jsonEncode(time.toString());
    data['interval'] = interval;
    data['notificationType'] = notificationType.name;
    return data;
  }
}
