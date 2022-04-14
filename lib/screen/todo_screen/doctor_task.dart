import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medical_assistant/widgets/todo_widgets/doctor_tile.dart';

import '../../controllers/doctor_controller.dart';
import '../../models/doctor_model.dart';
import '../../services/doctor_notification.dart';

import '../../todo_them/size_config.dart';
import '../../todo_them/theme.dart';

class DoctorTaskScreen extends StatefulWidget {
  const DoctorTaskScreen({Key? key}) : super(key: key);

  @override
  State<DoctorTaskScreen> createState() => _DoctorTaskScreenState();
}

class _DoctorTaskScreenState extends State<DoctorTaskScreen> {
  late DoctorNotification notifyHelper;
  SizeConfig size = SizeConfig();
  String? title;
  int? color;
  String? startTime;
  String? endTime;
  String? repeat;
  int? remind;
  String? note;
  int? isCompleted;
  String? date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = DoctorNotification();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    _taskController.getDoctorTask();
  }

  final DoctorController _taskController = DoctorController();
  DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    size.init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  _addDateTask(),
                  const SizedBox(
                    height: 15,
                  ),
                  _showNote()
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _fetch() async {
    await FirebaseFirestore.instance
        .collection('NotesDoctor')
        .doc('Xu6LjBwQPHj6QmKDcjpl')
        .get()
        .then((ds) {
      print('text');
      title = ds.data()!['title'];
      color = ds.data()!['color'];
      startTime = ds.data()!['startTime'];
      endTime = ds.data()!['endTime'];
      repeat = ds.data()!['repeat'];
      remind = ds.data()!['remind'];
      note = ds.data()!['note'];
      isCompleted = ds.data()!['isCompleted'];
      date = ds.data()!['date'];
      // print(date);
      _taskController.addTask(
          task: DoctorTask(
              title: title ?? 'xxxx',
              color: color ?? 0,
              startTime: startTime ?? '03:44',
              endTime: endTime ?? '04:44',
              repeat: repeat ?? 'Daily',
              remind: remind ?? 1,
              note: note ?? 'xx',
              isCompleted: isCompleted ?? 1,
              date: date ?? '02/02/2000'));
      print("test len ${_taskController.doctorTask.length}");
    }).catchError((e) {
      print(e);
    });
  }

  _showNote() {
    return Expanded(child: Obx(() {
      if (_taskController.doctorTask.isEmpty) {
        return _noTask();
      }
      return ListView.builder(
        itemCount: _taskController.doctorTask.length,
        itemBuilder: (BuildContext context, int index) {
          var task = _taskController.doctorTask[index];
          if (task.repeat == 'Delay' ||
              task.date == DateFormat.yMd().format(_selectedTime) ||
              (task.repeat == 'Weekly' &&
                  _selectedTime
                              .difference(DateFormat.yMd().parse(task.date!))
                              .inDays %
                          7 ==
                      0) ||
              (task.repeat == 'Monthly' &&
                  DateFormat.yMd().parse(task.date!).day ==
                      _selectedTime.day)) {
            var date = DateFormat.Hm().parse(task.startTime ?? '00:00');
            var myTime = DateFormat('HH:mm').format(date);
            DoctorNotification().scheduledNotification(
                int.parse(myTime.toString().split(':')[0]),
                int.parse(myTime.toString().split(':')[1]),
                task);
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 1500),
              child: SlideAnimation(
                horizontalOffset: 300,
                child: FadeInAnimation(
                  child: DoctorTile(task),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );
    }));
  }

  _addDateTask() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: _selectedTime,
        onDateChange: (newDate) {
          setState(() {
            _selectedTime = newDate;
          });
        },
        height: 100,
        width: 70,
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
      ),
    );
  }

  _noTask() {
    return Stack(
      children: [
        AnimatedPositioned(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  direction: SizeConfig.orientation == Orientation.landscape
                      ? Axis.horizontal
                      : Axis.vertical,
                  children: [
                    SizeConfig.orientation == Orientation.landscape
                        ? const SizedBox(height: 6)
                        : const SizedBox(height: 220),
                    SvgPicture.asset(
                      'assets/images/task.svg',
                      semanticsLabel: 'Task',
                      height: 90,
                      color: primaryClr.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        "Don't have any Task\nAdd new Task to make your Day productive",
                        style: subTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizeConfig.orientation == Orientation.landscape
                        ? const SizedBox(height: 180)
                        : const SizedBox(height: 160),
                  ],
                ),
              ),
            ),
            duration: const Duration(
              milliseconds: 2000,
            ))
      ],
    );
  }

  Future<void> _onRefresh() async {
    _taskController.getDoctorTask();
  }
}
