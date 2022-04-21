import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/todo_provider/todo_doctor_provider.dart';
import '../../provider/todo_provider/todo_patient_provider.dart';
import '../../services/todo_doctor_notification.dart';
import '../../services/todo_patient_notification.dart';
import '../../size_config.dart';
import '../../theme.dart';
import '../../widgets/todo_widget/patient_todo_widget/doctor_task_tile.dart';
import '../../widgets/todo_widget/patient_todo_widget/patient_task_tile.dart';


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
    Provider.of<DoctorTaskProvider>(context, listen: false).getTask();
  }

  //final TaskProvider _taskController = TaskProvider();
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
        body: FutureProvider(
          create: (context) =>
              Provider.of<DoctorTaskProvider>(context, listen: false).getTask(),
          initialData: [],
          child: Consumer<DoctorTaskProvider>(
            builder: (context, taskProvider, child) {
              return Column(children: [
                _addDateTask(),
                _showTask(),
              ]);
            },
          ),
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
          Provider.of<DoctorTaskProvider>(context,listen: false).deleteAllTask();
        },
      ),
      const SizedBox(width: 10)
    ],
  );

  _showTask() {
    return Expanded(
        child: Provider.of<DoctorTaskProvider>(context).doctorTask.isEmpty
            ? _noTask()
            : RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            scrollDirection:
            SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            itemCount: Provider.of<DoctorTaskProvider>(context).doctorTask.length,
            itemBuilder: (BuildContext context, int index) {
              var task =
              Provider.of<DoctorTaskProvider>(context).doctorTask[index];

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
                DateFormat.jm().parse(task.startTime.toString());
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
