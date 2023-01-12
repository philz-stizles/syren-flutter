import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService extends GetxService {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = '';

  Future<SqliteService> init() async {
    return this;
  }
}
