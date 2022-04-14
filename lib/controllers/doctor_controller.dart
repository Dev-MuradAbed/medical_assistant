import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../db/docotr_db.dart';
import '../models/doctor_model.dart';
import '../models/task_todo.dart';

class DoctorController extends GetxController {
  final RxList<DoctorTask> doctorTask = <DoctorTask>[].obs;

  Future<int> addTask({DoctorTask? task}) async {
    return DoctorHelper.insert(task!);
  }

  Future<void> getDoctorTask() async {
    final List<Map<String, dynamic>> tasks = await DoctorHelper.query();
    doctorTask.assignAll(tasks.map((data) => DoctorTask.fromJson(data)).toList());
  }

}