import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medical_assistant/models/todo_model/doctor_todo_model.dart';
import 'package:medical_assistant/models/todo_model/patient_todo_model.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../provider/todo_provider/todo_doctor_provider.dart';
import '../../provider/todo_provider/todo_patient_provider.dart';
import '../../services/todo_doctor_notification.dart';

import '../../size_config.dart';
import '../../theme.dart';
import '../../widgets/todo_widget/patient_todo_widget/doctor_task_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorHomeTodo extends StatefulWidget {
  const DoctorHomeTodo({Key? key}) : super(key: key);

  @override
  State<DoctorHomeTodo> createState() => _DoctorHomeTodoState();
}

class _DoctorHomeTodoState extends State<DoctorHomeTodo> {
  late DoctorNotificationHelper notifyHelper;
  SizeConfig size = SizeConfig();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = DoctorNotificationHelper(context);
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    Provider.of<TaskProvider>(context, listen: false).getTask();
  }

  final TaskProvider _taskController = TaskProvider();
  DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    size.init(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      color: Colors.white,
      child: Scaffold(
        //backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(),
        body: FutureBuilder(
          future: _feach(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return FutureBuilder(
                future: _feach(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return FutureProvider(
                      create: (context) =>
                          Provider.of<TaskProvider>(context, listen: false)
                              .getTask(),
                      initialData: [],
                      child: Consumer<TaskProvider>(
                        builder: (context, taskProvider, child) {
                          return Column(children: [
                            _addDateTask(),
                            _showTask(),
                          ]);
                        },
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/person.jpeg'),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(
              Icons.cleaning_services_outlined,
              size: 24,
            ),
            onPressed: () {
              notifyHelper.flutterLocalNotificationsPlugin.cancelAll();
              Provider.of<DoctorTaskProvider>(context, listen: false)
                  .deleteAllTask();
            },
          ),
          const SizedBox(width: 10)
        ],
      );

  _showTask() {
    return Expanded(
        child: Provider.of<TaskProvider>(context).listTask.isEmpty
            ? _noTask()
            : RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  scrollDirection:
                      SizeConfig.orientation == Orientation.landscape
                          ? Axis.horizontal
                          : Axis.vertical,
                  itemCount: Provider.of<TaskProvider>(context).listTask.length,
                  itemBuilder: (BuildContext context, int index) {
                    var task =
                        Provider.of<TaskProvider>(context).listTask[index];

                    if (task.repeat == 'Delay' ||
                        task.date == DateFormat.yMd().format(_selectedTime) ||
                        (task.repeat == 'Weekly' &&
                            _selectedTime
                                        .difference(
                                            DateFormat.yMd().parse(task.date!))
                                        .inDays %
                                    7 ==
                                0) ||
                        (task.repeat == 'Monthly' &&
                            DateFormat.yMd().parse(task.date!).day ==
                                _selectedTime.day)) {
                      var date =
                          DateFormat.Hm().parse(task.startTime.toString());
                      var myTime = DateFormat('HH:mm').format(date);
                      DoctorNotificationHelper(context).scheduledNotification(
                          int.parse(myTime.toString().split(':')[0]),
                          int.parse(myTime.toString().split(':')[1]),
                          task);
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1500),
                        child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                            child: DoctorTaskTile(task),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ));
  }

  _feach() async {
    await FirebaseFirestore.instance
        .collection('NotesDoctor')
        .get()
        .then((value) async {
      print(value.docs.length);
      for (int i = 0; i < value.docs.length; i++) {
        print("for");
        // print("if${Provider.of<TaskProvider>(context).listTask[i].id}");

        if (value.docs[i].data()['idpat'] == '123'
            // &&
            // value.docs[i].data()['idpat']!=Provider.of<TaskProvider>(context).listTask[i].id

            ) {
          try {
            await Provider.of<TaskProvider>(context, listen: false).
            addTask(
                  task: Task(
                title: value.docs[i].data()['title'] ?? 'title',
                note: value.docs[i].data()['note'] ?? 'title',
                color: value.docs[i].data()['color'] ?? 'title',
                isCompleted: value.docs[i].data()['isCompleted'] ?? 1,
                startTime: value.docs[i].data()['startTime'] ?? '00:00',
                endTime: value.docs[i].data()['endTime'] ?? '00:00',
                date: value.docs[i].data()['date'] ?? '00/00/0000',
                remind: value.docs[i].data()['remind'] ?? 0,
                repeat: value.docs[i].data()['repeat'] ?? 'Daily',
              ));
            // await _taskController.addTask(
            //     task: Task(
            //   title: value.docs[i].data()['title'] ?? 'title',
            //   note: value.docs[i].data()['note'] ?? 'title',
            //   color: value.docs[i].data()['color'] ?? 'title',
            //   isCompleted: value.docs[i].data()['isCompleted'] ?? 1,
            //   startTime: value.docs[i].data()['startTime'] ?? '00:00',
            //   endTime: value.docs[i].data()['endTime'] ?? '00:00',
            //   date: value.docs[i].data()['date'] ?? '00/00/0000',
            //   remind: value.docs[i].data()['remind'] ?? 0,
            //   repeat: value.docs[i].data()['repeat'] ?? 'Daily',
            // ));
            print('length${_taskController.listTask.length}');
          } catch (e) {
            print(e);
          }
        }
      }
    });
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
    Provider.of<DoctorTaskProvider>(context).getTask();
  }
}
