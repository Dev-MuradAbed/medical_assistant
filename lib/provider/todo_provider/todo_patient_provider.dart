import 'package:flutter/material.dart';


import '../../database/patient_controller.dart';
import '../../models/todo_model/patient_todo_model.dart';


class TaskProvider extends ChangeNotifier {
  final TaskController _taskController = TaskController();
  List<Task> listTask = <Task>[];

  Future<int> addTask({required Task task}) async {
    int newRow = await _taskController.insert(task);
    if (newRow != 0) {
      listTask.add(task);
      notifyListeners();
    }
    return newRow;
  }

  Future<void>getTask() async {
    final List<Map<String, dynamic>> tasks = await _taskController.query();
    listTask = tasks.map((Map<String, dynamic> task) => Task.fromJson(task)).toList();
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
