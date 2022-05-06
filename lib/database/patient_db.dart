import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  static final DbController _instance = DbController._();

  factory DbController() {
    return _instance;
  }
  DbController._();

  late Database _database;

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db.sql');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute(
        'CREATE TABLE tasks ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title STRING, '
        'note TEXT, '
        'isCompleted INTEGER, '
        'color INTEGER, '
        'startTime STRING, '
        'endTime STRING, '
        'date INTEGER, '
        'remind INTEGER, '
        'repeat STRING)',
      );
      db.execute(
        'CREATE TABLE doctor ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title STRING, '
        'note TEXT, '
        'isCompleted INTEGER, '
        'color INTEGER, '
        'startTime STRING, '
        'endTime STRING, '
        'idNote STRING, '
        'date INTEGER, '
        'remind INTEGER, '
        'repeat STRING)',
      );
      db.execute(
        'CREATE TABLE result ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'sy INTEGER, '
        'dy INTEGER, '
        'heartRate INTEGER, '
        'date INTEGER, '
        'hourTime STRING, '
        'munitTime STRING, '
        'dayDate INTEGER, '
        'yearTime STRING, '
        'heartRateType STRING, '
        'monthTime STRING)',
      );
      db.execute(
        'CREATE TABLE profile ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'name STRING, '
            'email STRING, '
            'phone STRING, '
            'other STRING, '
            'gender STRING, '
            'height STRING, '
            'wight STRING, '
            'birthday STRING, '
            'image STRING, '
            'type STRING)',
      );
    });
    print('Database created');
  }
}
