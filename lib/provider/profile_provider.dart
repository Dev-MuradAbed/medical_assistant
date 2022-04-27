import 'package:flutter/material.dart';
import '../../models/todo_model/patient_todo_model.dart';
import '../database/controller/profile_controller.dart';
import '../models/profile_model.dart';


class ProfileProvider extends ChangeNotifier {
  final profileController _taskController = profileController();
  List<Profile> listTask = <Profile>[];

  Future<int> addTask({required Profile task}) async {
    print('inserting task');
    int newRow = await _taskController.insert(task);
    if (newRow != 0) {
      listTask.add(task);
      notifyListeners();
    }
    return newRow;
  }

  Future<void>getTask() async {
    final List<Map<String, dynamic>> tasks = await _taskController.query();
    listTask = tasks.map((Map<String, dynamic> task) => Profile.fromJson(task)).toList();
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
