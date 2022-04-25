
import 'package:medical_assistant/models/result_model.dart';
import 'package:sqflite/sqflite.dart';

import '../patient_db.dart';

class ResultController{
  Database database = DbController().database;
  Future<int> insert(ResultModel task) async {
    print('insert function code ${task.sy}');
    print(task.toJson());
    return await database.insert('result', task.toJson());
  }

  Future<int> delete(int id) async {
    return await database.delete('result', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTask() async {
    print('delete All function code');
    return await database.delete('result');
  }

  Future<List<Map<String, dynamic>>> query() async {
    print('query function code');
    return await database.query('result');
  }

  // Future<int> update(int id) async {
  //   print('update function code ');
  //   return await database.rawUpdate('''
  //   UPDATE tasks
  //   SET isCompleted = ?
  //   WHERE id = ?
  //   ''', [1, id]);
  // }
  // Future<bool> FutureCheckId(int id) async {
  //   print('check id function code');
  //   var c= await database.rawQuery('''
  //   SELECT *
  //   FROM tasks
  //   WHERE id = ?
  //   ''', [id]);
  //   if(c.isEmpty){
  //     return false;
  //   }
  //   return true;
  // }
}