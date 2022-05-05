import 'package:flutter/material.dart';

import '../../database/controller/doctor_controller.dart';

import '../../models/todo_model/doctor_todo_model.dart';

class TaskDoctorProvider extends ChangeNotifier {
  final TaskDoctorController _taskController = TaskDoctorController();
  List<DoctorTask> listTask = <DoctorTask>[];

  Future<int> addTask(
      {required DoctorTask task, required String idNote}) async {
    var check = await _taskController.FutureCheckId(idNote);
    int newRow = await _taskController.insert(task);
    if (check == false) {
      if (newRow != 0) {
        listTask.add(task);
        notifyListeners();
      }
    } else {}

    return newRow;
  }

  Future<void> getTask() async {
    final List<Map<String, dynamic>> tasks = await _taskController.query();
    listTask = tasks
        .map((Map<String, dynamic> task) => DoctorTask.fromJson(task))
        .toList();
    notifyListeners();
  }
}
