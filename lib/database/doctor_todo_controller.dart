import 'package:medical_assistant/models/todo_model/doctor_todo_model.dart';
import 'package:sqflite/sqflite.dart';

import 'controller/patient_db.dart';

class DoctorTaskController{
  Database database = DbController().database;
  Future<int> insert(DoctorTask task) async {
    print('insert Doctor Task function code');
    return await database.insert('doctorTask', task.toJson());
  }

  Future<int> delete(int id) async {
    return await database.delete('doctorTask', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTask() async {
    print('delete All function code');
    return await database.delete('doctorTask');
  }

  Future<List<Map<String, dynamic>>> query() async {
    print('query function code');
    return await database.query('doctorTask');
  }

  // Future<int> update(int id) async {
  //   print('update function code ');
  //   return await database.rawUpdate('''
  //   UPDATE tasks
  //   SET isCompleted = ?
  //   WHERE id = ?
  //   ''', [1, id]);
  // }
}