import 'package:flutter/material.dart';


import '../../database/controller/doctor_controller.dart';
import '../../database/controller/patient_controller.dart';
import '../../models/todo_model/doctor_todo_model.dart';
import '../../models/todo_model/patient_todo_model.dart';


class TaskDoctorProvider extends ChangeNotifier {
  final TaskDoctorController _taskController = TaskDoctorController();
  List<DoctorTask> listTask = <DoctorTask>[];

  Future<int> addTask({required DoctorTask task}) async {
    print('task: ${task.title}');
    int newRow = await _taskController.insert(task);
    if (newRow != 0) {
      listTask.add(task);
      notifyListeners();
    }
    return newRow;
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
