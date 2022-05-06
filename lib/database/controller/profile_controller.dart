import 'package:medical_assistant/models/profile_model.dart';
import 'package:sqflite/sqflite.dart';
import '../patient_db.dart';

class profileController{
  Database database = DbController().database;
  Future<int> insert(Profile task) async {

    return await database.insert('profile', task.toJson());
  }

  Future<int> delete(int id) async {
    return await database.delete('profile', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTask() async {

    return await database.delete('profile');
  }

  Future<List<Map<String, dynamic>>> query() async {

    return await database.query('profile');
  }

  Future<int> update(int id) async {
    return await database.rawUpdate('''
    UPDATE profile 
    SET isCompleted = ? 
    WHERE id = ?  
    ''', [1, id]);
  }
  Future<int>updateprofile(Profile profile) async {
    var db =  database;
    var result=await db.update('profile',profile.toJson(),where: 'id = ?',whereArgs: [profile.id]);
    return result;
  }

  Future<bool> FutureCheckId(int id) async {
    print('check id function code');
    var c= await database.rawQuery('''
    SELECT * 
    FROM profile 
   
    WHERE id = ?  
    ''', [id]);
    if(c.isEmpty){
      return false;
    }
    return true;
  }
}