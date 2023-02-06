import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syren/models/models.dart';

class ReminderService extends GetxService {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'Reminders';

  // Observables.
  RxList<ReminderModel> reminders = <ReminderModel>[].obs;

  @override
  Future<void> onReady() async {
    await getReminders();
    super.onReady();
  }

  Future<ReminderService> init() async {
    try {
      if (_db == null) {
        String path = '${await getDatabasesPath()}SyrenDB.db';
        _db = await openDatabase(path, version: _version,
            onCreate: (Database db, int version) async {
          await db.execute('''
        create table $_tableName ( 
          id integer primary key autoincrement, 
          title string not null,
          note text,
          body text,
          date string,
          isRead integer,
          isCompleted integer, 
          timestamp string,
          time string,
          interval string,
          notificationType string
          )
        ''');
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint('Init Reminder Service');
    return this;
  }

  Future<void> getReminders() async {
    try {
      reminders.assignAll(await query());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> insert(ReminderModel model) async {
    await _insert(model);

    await getReminders();
  }

  Future<void> clearAll() async {
    var affectedRecords = await _deleteAll();
    if (affectedRecords > 0) {
      await getReminders();
    }
  }

  Future<void> clearByType(NotificationType type) async {
    var affectedRecords = await _db!.delete(_tableName,
        where: 'notificationType = ?', whereArgs: [type.name]);
    if (affectedRecords > 0) {
      await getReminders();
    }
  }

  Future<ReminderModel?> _insert(ReminderModel? model) async {
    var id = await _db?.insert(_tableName, model!.toJson());
    model?.id = id;
    return model;
  }

  Future<List<ReminderModel>> query() async {
    try {
      return (await _db?.query(_tableName, orderBy: 'date DESC'))!
          .map((e) => ReminderModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<ReminderModel?> get(int id) async {
    List<Map<String, Object?>>? maps = await _db?.query(_tableName,
        columns: ['id', 'title', 'note'], where: 'id = ?', whereArgs: [id]);
    if (maps != null && maps.isNotEmpty) {
      return ReminderModel.fromJson(maps.first);
    }
    return null;
  }

  Future<int> markAsRead(int id) async {
    return await _db!
        .update(_tableName, {'isRead': 1}, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> markAllAsRead() async {
    return await _db!.update(_tableName, {'isRead': 1});
  }

  Future<int> delete(int id) async {
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> _deleteAll() async {
    return await _db!.delete(_tableName);
  }

  Future<int> update(ReminderModel model) async {
    return await _db!.update(_tableName, model.toJson(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future close() async => _db!.close();
}
