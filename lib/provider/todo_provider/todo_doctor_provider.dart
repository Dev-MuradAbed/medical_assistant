import 'package:flutter/material.dart';


import '../../database/controller/doctor_controller.dart';
import '../../database/controller/patient_controller.dart';
import '../../models/todo_model/doctor_todo_model.dart';
import '../../models/todo_model/patient_todo_model.dart';


class TaskDoctorProvider extends ChangeNotifier {
  final TaskDoctorController _taskController = TaskDoctorController();
  List<DoctorTask> listTask = <DoctorTask>[];
/*
* create addDoctor from model DoctorTask check model idNote if new row not equal 0 and id note in sql not frequatity add in list
* */

  // addTask({required DoctorTask task}) async {
  //   print('addTask');
  //   if (task.idNote != 0 && task.idNote != null) {
  //     await _taskController.insert(task);
  //     listTask.add(task);
  //     notifyListeners();
  //   }
  // }

// create addnote provider if note not null and id note not equal 0 and not exixt in sql add in list
  addTask({required DoctorTask task,required String idnote})async{
    bool check = await _taskController.FutureCheckId(idnote);
    if(check == false){
      await _taskController.insert(task);
      listTask.add(task);
      notifyListeners();
    }
    else{
      print('id note is exixt');
    }
  }

  Future<void>getTask() async {
    print('getTask');
    final List<Map<String, dynamic>> tasks = await _taskController.query();
    listTask = tasks.map((Map<String, dynamic> task) => DoctorTask.fromJson(task)).toList();
    notifyListeners();
  }
  void delete(Task task) async {
    await _taskController.delete(task.id!);
    getTask();
    notifyListeners();
  }
  Future<void> deleteAllTask() async {
    await _taskController.deleteAllTask();
    print('sucsess delete');
    getTask();
    notifyListeners();
  }

  void markTaskCompleted(int id) async {
    await _taskController.update(id);
    getTask();
    notifyListeners();
  }
}
