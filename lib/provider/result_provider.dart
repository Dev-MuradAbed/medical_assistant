
import 'package:flutter/material.dart';
import 'package:medical_assistant/database/controller/result_controller.dart';
import 'package:medical_assistant/models/result_model.dart';

class ResultProvider extends ChangeNotifier {
  final ResultController _taskController = ResultController();
  List<ResultModel> resultList = <ResultModel>[];
  Future<int> addRecord({required ResultModel task}) async {
    int newRowId = await _taskController.insert(task);
    if (newRowId != 0) {
      resultList.add(task);
      notifyListeners();
    }
    return newRowId;
  }

  Future<void>getRecord() async {
    final List<Map<String, dynamic>> tasks = await _taskController.query();
    resultList = tasks.map((Map<String, dynamic> task) => ResultModel.fromJson(task)).toList();
    notifyListeners();
  }


}
