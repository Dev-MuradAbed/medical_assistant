import 'package:sqflite/sqflite.dart';
import '../../models/todo_model/patient_todo_model.dart';
import '../patient_db.dart';

class TaskController{
  Database database = DbController().database;
  Future<int> insert(Task task) async {
    print('insert function code');
    return await database.insert('tasks', task.toJson());
  }

  Future<int> delete(int id) async {
    return await database.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTask() async {
    print('delete All function code');
    return await database.delete('tasks');
  }

  Future<List<Map<String, dynamic>>> query() async {
    print('query function code');
    return await database.query('tasks');
  }

  Future<int> update(int id) async {
    print('update function code ');
    return await database.rawUpdate('''
    UPDATE tasks 
    SET isCompleted = ? 
    WHERE id = ?  
    ''', [1, id]);
  }
  Future<bool> FutureCheckId(int id) async {
    print('check id function code');
    var c= await database.rawQuery('''
    SELECT * 
    FROM tasks 
    WHERE id = ?  
    ''', [id]);
    if(c.isEmpty){
      return false;
    }
    return true;
  }
}