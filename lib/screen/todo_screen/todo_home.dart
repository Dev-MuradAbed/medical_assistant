import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_assistant/screen/todo_screen/patient_home_todo.dart';

import '../../theme.dart';
import 'doctor_home_todo.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(
      child: Center(
        child: Text(
          'My Notes',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Candara',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10),

        child: const Text(
          'Doctor\'s Notes',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Candara',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: subheading,
            ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
          indicatorColor: greenClr,
          labelColor: Colors.white,
          unselectedLabelColor: blueClr,
          isScrollable: true,
          indicatorWeight: 3,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: greenClr,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PatientHomeTodo(),
          DoctorHomeTodo(),
        ],
      ),
    );
  }
}
