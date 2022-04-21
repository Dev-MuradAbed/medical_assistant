import 'package:flutter/material.dart';
import 'package:medical_assistant/models/todo_model/doctor_todo_model.dart';


import '../../database/doctor_todo_controller.dart';
import '../../models/todo_model/patient_todo_model.dart';


class DoctorTaskProvider extends ChangeNotifier {
  final DoctorTaskController _taskController = DoctorTaskController();
  List<DoctorTask> doctorTask = <DoctorTask>[];

  Future<int> addTask({required DoctorTask task}) async {
    int newRow = await _taskController.insert(task);
    if (newRow != 0) {
      doctorTask.add(task);
      notifyListeners();
    }
    return newRow;
  }

  Future<void>getTask() async {
    final List<Map<String, dynamic>> tasks = await _taskController.query();
    doctorTask = tasks.map((Map<String, dynamic> task) => DoctorTask.fromJson(task)).toList();
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
}
