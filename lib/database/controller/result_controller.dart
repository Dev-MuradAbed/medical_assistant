import 'package:medical_assistant/models/result_model.dart';
import 'package:sqflite/sqflite.dart';

import '../patient_db.dart';

class ResultController {
  Database database = DbController().database;

  Future<int> insert(ResultModel task) async {
    return await database.insert('result', task.toJson());
  }

  Future<int> delete(int id) async {
    return await database.delete('result', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTask() async {
    return await database.delete('result');
  }

  Future<List<Map<String, dynamic>>> query() async {
    return await database.query('result');
  }
}
