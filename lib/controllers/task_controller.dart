import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task_todo.dart';

class TaskController extends GetxController {
  final RxList<Task> listTask = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return DBHelper.insert(task!);
  }

  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    listTask.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTask() async {
    await DBHelper.deleteAllTask();
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
