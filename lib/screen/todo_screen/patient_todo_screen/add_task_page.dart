
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/todo_controller/patient_controller.dart';
import '../../../models/todo_model/todo_patient.dart';
import '../../../todo_them/theme.dart';

import '../../../widgets/todo_widgets/patient_todo_widget/button.dart';
import '../../../widgets/todo_widgets/patient_todo_widget/input_field.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = TaskController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedTime = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectRepeat = 'None';
  List<String> repeatList = ['None', 'Delay', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Add Task',
                  style: heading,
                ),
                InputField(
                  title: 'Title',
                  hint: 'Enter Title Task',
                  controller: _titleController,
                ),
                InputField(
                  title: 'Note',
                  hint: 'Enter Note Task',
                  controller: _noteController,
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectedTime),
                  widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => _getDate(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: InputField(
                      title: 'Start Time',
                      hint: startTime,
                      widget: IconButton(
                        onPressed: () => _getTime(isStart: true),
                        icon: const Icon(Icons.access_time, color: Colors.grey),
                      ),
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                        child: InputField(
                      title: 'End Time',
                      hint: endTime,
                      widget: IconButton(
                        onPressed: () => _getTime(isStart: false),
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                      ),
                    )),
                  ],
                ),
                InputField(
                  title: 'Remind',
                  hint: '$_selectRemind minuet early',
                  widget: Row(
                    children: [
                      DropdownButton(
                        underline: Container(height: 0),
                        borderRadius: BorderRadius.circular(10),
                        elevation: 4,
                        style: subTitle,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey,
                        ),
                        iconSize: 30,
                        items: remindList.map<DropdownMenuItem<String>>(
                            (int value) => DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text('$value'))).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            _selectRemind = int.parse(newvalue!);
                          });
                        },
                      ),
                      const SizedBox(width: 6)
                    ],
                  ),
                ),
                InputField(
                  title: 'Repeat',
                  hint: _selectRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        underline: Container(height: 0),
                        style: subTitle,
                        items: repeatList
                            .map<DropdownMenuItem<String>>((String value) =>
                                DropdownMenuItem<String>(
                                    value: value, child: Text(value)))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectRepeat = value!;
                          });
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey,
                        ),
                        iconSize: 30,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 4,
                      ),
                      const SizedBox(width: 6)
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    columnMethode(),
                    MyButton(
                        label: 'Create Task',
                        onTap: () {
                          validateTask();
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          color: Get.isDarkMode ? Colors.white : Colors.black,
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
          onPressed: () => Get.back(),
        ),
        actions: const [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/person.jpeg'),
          ),
          SizedBox(width: 6)
        ],
      );

  Column columnMethode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color'),
        Wrap(
          children: List.generate(
              3,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: index == 0
                            ? primaryClr
                            : index == 1
                                ? pinkClr
                                : orangeClr,
                        radius: 14,
                        child: _selectedColor == index
                            ? const Icon(Icons.done,
                                size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                  )),
        )
      ],
    );
  }

  validateTask() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required ', 'All filed require ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } else {
      print('nothing');
    }
  }

  _addTaskToDb() async {
    try{
      int value =await _taskController.addTask(task: Task(
        title: _titleController.text,
        note: _noteController.text,
        color: _selectedColor,
        isCompleted: 0,
        startTime: startTime,
        endTime: endTime,
        date: DateFormat.yMd().format(_selectedTime),
        remind: _selectRemind,
        repeat: _selectRepeat,
      ));
      print('$value');
    }catch(e){
      print(e);
    }
  }

  _getDate() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedTime,
      firstDate: DateTime(2010),
      lastDate: DateTime(2040),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedTime = _pickedDate;
      });
    } else {
      print('Nothing');
    }
  }

  _getTime({required bool isStart}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: isStart
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(

                const Duration(minutes: 15),
              ),
            ),
    );
    String _formatDate = _pickedTime!.format(context);
    if (isStart) {
      setState(() {
        startTime = _formatDate;
      });
    } else if (!isStart) {
      setState(() {
        endTime = _formatDate;
      });
    } else {
      print('Nothing');
    }
  }
}
