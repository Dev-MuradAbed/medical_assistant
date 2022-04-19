import 'package:get/get.dart';

import '../../db/todo_db/docotr_db.dart';
import '../../models/todo_model/todo_doctor.dart';

class DoctorController extends GetxController {
  final RxList<DoctorTask> doctorTask = <DoctorTask>[].obs;

  Future<dynamic> addTask({DoctorTask? task}) async {
    return DoctorHelper.insertDoctor(task!);
  }

  Future<void> getDoctorTask() async {
    final List<Map<String, dynamic>> tasks = await DoctorHelper.query();
    doctorTask.assignAll(tasks.map((data) => DoctorTask.fromJson(data)).toList());
  }
  void deleteAllTask() async {
    await DoctorHelper.deleteAllTask();
    getDoctorTask();
  }

}
