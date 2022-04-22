import 'package:medical_assistant/models/todo_model/doctor_todo_model.dart';
import 'package:sqflite/sqflite.dart';

import '../patient_db.dart';

class TaskDoctorController{
  Database database = DbController().database;
  Future<int> insert(DoctorTask task) async {
    print('insert function code doctorTasks');
    return await database.insert('doctor', task.toJson());
  }

  Future<int> delete(int id) async {
    return await database.delete('doctor', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTask() async {
    print('delete All function code');
    return await database.delete('doctor');
  }

  Future<List<Map<String, dynamic>>> query() async {
    print('query function code');
    return await database.query('doctor');
  }

  Future<int> update(int id) async {
    print('update function code ');
    return await database.rawUpdate('''
    UPDATE doctor 
    SET isCompleted = ? 
    WHERE id = ?  
    ''', [1, id]);
  }
  Future<bool> FutureCheckId(int id) async {
    print('check id function code');
    var c= await database.rawQuery('''
    SELECT * 
    FROM doctor 
    WHERE id = ?  
    ''', [id]);
    if(c.isEmpty){
      return false;
    }
    return true;
  }
}