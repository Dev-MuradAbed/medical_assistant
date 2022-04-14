import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/doctor_model.dart';



class DoctorHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'taskDoctor';

  static Future<void> initDB() async {
    if (_db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'taskDoctor.db';
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
              // When creating the db, create the table
              return db.execute(
                'CREATE TABLE $_tableName ('
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
            });
        print('CREATE DATABASE ');
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(DoctorTask? task) async {
    print('insert function code');
    return await _db?.insert(_tableName, task!.toJson())??1;

  }


  static Future<List<Map<String, dynamic>>> query() async {
    print('query function code');
    return await _db!.query(_tableName);
  }

}
