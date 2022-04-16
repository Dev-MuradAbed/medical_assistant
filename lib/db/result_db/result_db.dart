import 'package:flutter/material.dart';
import 'package:medical_assistant/models/result_model/result_model.dart';
import 'package:sqflite/sqflite.dart';





class ResultDbHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'resultDb';

  static Future<void> initDB() async {
    if (_db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'resultDb.db';
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
              // When creating the db, create the table
              return db.execute(
                'CREATE TABLE $_tableName ('
                    'minuteTime STRING, '
                    'hourTime STRING, '
                    'bpm INTEGER, '
                    'date INTEGER)',
              );
            });
        print('CREATE DATABASE ResultDb');
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insertDoctor(ResultModel? task) async {
    print('insert function code to ResultDb');
  var x=  await _db?.insert(_tableName, task!.toJson())??1;
  print(x);
    return x;

  }
  // static Future<int> deleteAllTask() async {
  //   print('delete All function code');
  //   return await _db!.delete(_tableName);
  // }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query function code ');
    return await _db!.query(_tableName);
  }

}
