import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medical_assistant/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../models/todo_model/patient_todo_model.dart';
import '../../provider/todo_provider/todo_patient_provider.dart';
import '../../services/todo_patient_notification.dart';
import '../../size_config.dart';
import '../../theme.dart';
import '../../widgets/todo_widget/patient_todo_widget/button.dart';
import '../../widgets/todo_widget/patient_todo_widget/patient_task_tile.dart';
import 'patient_add_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PatientHomeTodo extends StatefulWidget {
  const PatientHomeTodo({Key? key}) : super(key: key);

  @override
  State<PatientHomeTodo> createState() => _PatientHomeTodoState();
}

class _PatientHomeTodoState extends State<PatientHomeTodo> with Helper {
  late PatientNotificationHelper notifyHelper;
  SizeConfig size = SizeConfig();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = PatientNotificationHelper(context);
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    Provider.of<TaskProvider>(context, listen: false).getTask();
  }

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
        backgroundColor: white,
        body: FutureProvider(
          create: (context) =>
              Provider.of<TaskProvider>(context, listen: false).getTask(),
          initialData: [],
          child: Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              return Column(children: [
                _addTask(),
                _addDateTask(),
                _showTask(),

              ]);
            },
          ),
        ),
floatingActionButtonLocation:FloatingActionButtonLocation.endTop ,
      ),
    );
  }



  _showTask() {
    return Expanded(
        child: Provider.of<TaskProvider>(context).listTask.isEmpty
            ? noTask(_onRefresh,
                "${AppLocalizations.of(context)!.dont_have_any_task}\n${AppLocalizations.of(context)!.add_new_task_to_make_your_day_productive}",context)
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
                          DateFormat.jm().parse(task.startTime.toString());
                      var myTime = DateFormat('HH:mm').format(date);
                      PatientNotificationHelper(context).scheduledNotification(
                          int.parse(myTime.toString().split(':')[0]),
                          int.parse(myTime.toString().split(':')[1]),
                          task);
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1500),
                        child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {

                                showBottomSheet(context, task);
                              },
                              child: TaskTile(task),
                            ),
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

  _addTask() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subheading,
              ),
              Text('Today', style: heading)
            ],
          ),
          MyButton(
              label: AppLocalizations.of(context)!.add_task,
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTaskPage(),
                    ));
                Provider.of<TaskProvider>(context, listen: false).getTask();

              })
        ],
      ),
    );
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

  showBottomSheet(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 4),
            width: SizeConfig.screenWidth,
            height: (SizeConfig.orientation == Orientation.landscape)
                ? (task.isCompleted == 1
                    ? SizeConfig.screenHeight * 0.6
                    : SizeConfig.screenHeight * 0.8)
                : (task.isCompleted == 1
                    ? SizeConfig.screenHeight * 0.30
                    : SizeConfig.screenHeight * 0.39),
            color: Colors.white,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: 6,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300]),
                  ),
                ),
                const SizedBox(height: 10),
                task.isCompleted == 1
                    ? Container()
                    : _buildBottomSheet(
                        label: AppLocalizations.of(context)!.completed_task,
                        clr: primaryClr,
                        onTap: () async {
                          Provider.of<TaskProvider>(context, listen: false)
                              .markTaskCompleted(task.id!);
                          await notifyHelper.flutterLocalNotificationsPlugin
                              .cancel(task.id!);
                          Navigator.pop(context);
                        }),
                _buildBottomSheet(
                    label: AppLocalizations.of(context)!.delete_task,
                    clr: Colors.red[300]!,
                    onTap: () async {
                      Provider.of<TaskProvider>(context, listen: false)
                          .delete(task);
                      await notifyHelper.flutterLocalNotificationsPlugin
                          .cancel(task.id!);


                      Navigator.pop(context);
                    }),
                const Divider(
                  color: darkGreyClr,
                ),
                _buildBottomSheet(
                    label: AppLocalizations.of(context)!.cancel,
                    clr: primaryClr,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }

  _buildBottomSheet(
      {required String label,
      required Function() onTap,
      required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            border:
                Border.all(width: 2, color: isClose ? Colors.grey[200]! : clr),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    Provider.of<TaskProvider>(context).getTask();
  }
}
