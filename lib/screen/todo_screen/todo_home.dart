import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/screen/todo_screen/patient_todo_screen/home_page.dart';

import '../../them.dart';
import 'doctor_todo_screen/doctor_task.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(text: 'My Notes', height: 50),
    const Tab(text: 'Patients\' notes',height: 50),
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
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelPadding: const EdgeInsets.only(left: 25, right: 25),
            labelStyle: const TextStyle(

              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Candara',
            ),
            controller: _tabController,
            tabs: tabs,
            isScrollable: true,
           unselectedLabelColor: blueClr,
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Candara',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BubbleTabIndicator(

              indicatorHeight: 25.0,
              indicatorColor: greenClr,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),

          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
          HomePage(),
            DoctorTaskScreen()
            ,
          ],
        ),
      ),
    );
  }
}
