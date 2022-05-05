import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:medical_assistant/models/todo_model/doctor_todo_model.dart';
import 'package:medical_assistant/utils/helpers.dart';
import 'package:provider/provider.dart';
import '../../provider/todo_provider/todo_doctor_provider.dart';
import '../../services/todo_Doctor_notification.dart';
import '../../size_config.dart';
import '../../theme.dart';
import '../../widgets/todo_widget/patient_todo_widget/doctor_task_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//AppLocalizations.of(context)!.
class DoctorHomeTodo extends StatefulWidget {
  const DoctorHomeTodo({Key? key}) : super(key: key);

  @override
  State<DoctorHomeTodo> createState() => _DoctorHomeTodoState();
}

class _DoctorHomeTodoState extends State<DoctorHomeTodo> with Helper {
  late DoctorNotificationHelper notifyHelper;
  SizeConfig size = SizeConfig();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = DoctorNotificationHelper(context);
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    Provider.of<TaskDoctorProvider>(context, listen: false).getTask();
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
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: _feach(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return FutureProvider(
                create: (context) =>
                    Provider.of<TaskDoctorProvider>(context, listen: false)
                        .getTask(),
                initialData: [],
                child: Consumer<TaskDoctorProvider>(
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
        ),
      ),
    );
  }

  _showTask() {
    return Expanded(
        child: Provider.of<TaskDoctorProvider>(context).listTask.isEmpty
            ? noTask(_onRefresh,
                "${AppLocalizations.of(context)!..dont_have_any_task}\n${AppLocalizations.of(context)!.add_new_task_to_make_your_day_productive}"
            ,context)
            : RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  scrollDirection:
                      SizeConfig.orientation == Orientation.landscape
                          ? Axis.horizontal
                          : Axis.vertical,
                  itemCount:
                      Provider.of<TaskDoctorProvider>(context).listTask.length,
                  itemBuilder: (BuildContext context, int index) {
                    var task = Provider.of<TaskDoctorProvider>(context)
                        .listTask[index];

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
    var uuidUser = FirebaseAuth.instance.currentUser!.uid;
    var fireStronsSub =
        FirebaseFirestore.instance.collection('UserData').doc(uuidUser);
    var pr = Provider.of<TaskDoctorProvider>(context, listen: false);
    fireStronsSub.collection("DoctorNote").snapshots().listen((data) {
      data.docs.forEach((doc) async {
        print(doc.id);
        if (pr.listTask.where((element) => element.idNote != doc.id).isEmpty) {

          await pr.addTask(
              idNote: doc.id,
              task: DoctorTask(
                title: doc.data()['title'],
                note: doc.data()['note'],
                remind: doc.data()['remind'],
                isCompleted: doc.data()['isCompleted'],
                color: doc.data()['color'],
                idNote: doc.id,
                repeat: doc.data()['repeat'],
                endTime: doc.data()['endTime'],
                startTime: doc.data()['startTime'],
                date: doc.data()['date'],
              ));
          Provider.of<TaskDoctorProvider>(context).getTask();
        } else {
          print('empty');
        }
      });
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

  Future<void> _onRefresh() async {
    Provider.of<TaskDoctorProvider>(context).getTask();
  }
}
