import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syren/models/models.dart';

class VitalReminderService extends GetxService {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'vitalReminders';

  Future<VitalReminderService> init() async {
    try {
      if (_db == null) {
        String path = '${await getDatabasesPath()}reminders.db';
        _db = await openDatabase(path, version: _version,
            onCreate: (Database db, int version) async {
          await db.execute('''
        create table $_tableName ( 
          id integer primary key autoincrement, 
          title string not null,
          note text,
          date string,
          startTime string,
          endTime string,
          remind integer,
          repeat string,
          isCompleted integer)
        ''');
        });
      }
    } catch (e) {
      print(e);
    }
    debugPrint('Init Vital Reminder Service}');
    return this;
  }

  Future<VitalReminderModel?> insert(VitalReminderModel? model) async {
    var id = await _db?.insert(_tableName, model!.toJson());
    debugPrint(id.toString());
    model?.id = id;
    return model;
  }

  Future<List<VitalReminderModel>> query() async {
    return (await _db?.query(_tableName))!
        .map((e) => VitalReminderModel.fromJson(e))
        .toList();
  }

  // Future<VitalReminderModel?> getVitalReminderModel(int id) async {
  //   List<Map> maps = await _db?.query(_tableName,
  //       columns: ['id', 'title', 'note'],
  //       where: 'id = ?',
  //       whereArgs: [id]);
  //   if (maps.isNotEmpty) {
  //     return VitalReminderModel.fromJson(maps.first as Map<String, dynamic>);
  //   }
  //   return null;
  // }

  Future<int> delete(int id) async {
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(VitalReminderModel model) async {
    return await _db!.update(_tableName, model.toJson(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future close() async => _db!.close();
}
