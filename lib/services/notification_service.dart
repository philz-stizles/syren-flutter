import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syren/models/models.dart';

class NotificationService extends GetxService {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'notifications';

  Future<NotificationService> init() async {
    try {
      if (_db == null) {
        String path = '${await getDatabasesPath()}Syren.db';
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
      print(e);
    }
    debugPrint('Init Notification Service');
    return this;
  }

  Future<NotificationModel?> insert(NotificationModel? model) async {
    var id = await _db?.insert(_tableName, model!.toJson());
    model?.id = id;
    return model;
  }

  Future<List<NotificationModel>> query() async {
    try {
      return (await _db?.query(_tableName, orderBy: 'date DESC'))!
          .map((e) => NotificationModel.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<NotificationModel?> get(int id) async {
    List<Map<String, Object?>>? maps = await _db?.query(_tableName,
        columns: ['id', 'title', 'note'], where: 'id = ?', whereArgs: [id]);
    if (maps != null && maps.isNotEmpty) {
      return NotificationModel.fromJson(maps.first);
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

  Future<int> deleteAll() async {
    return await _db!.delete(_tableName);
  }

  Future<int> update(NotificationModel model) async {
    return await _db!.update(_tableName, model.toJson(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future close() async => _db!.close();
}
