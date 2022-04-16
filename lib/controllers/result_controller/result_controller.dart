import 'package:get/get.dart';
import 'package:medical_assistant/models/result_model/result_model.dart';

import '../../db/result_db/result_db.dart';


class ResultController extends GetxController {
  final RxList<ResultModel> resultList = <ResultModel>[].obs;

  Future<int> addTask({ResultModel? task}) async {
    return ResultDbHelper.insertDoctor(task);
  }

  Future<void> getDoctorTask() async {
    final List<Map<String, dynamic>> tasks = await ResultDbHelper.query();
    resultList.assignAll(tasks.map((data) => ResultModel.fromJson(data)).toList());

   }
  // void deleteAllTask() async {
  //   await ResultDbHelper.deleteAllTask();
  //   getDoctorTask();
  // }

}