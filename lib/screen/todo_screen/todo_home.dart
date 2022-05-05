import 'package:flutter/material.dart';
import 'package:medical_assistant/screen/todo_screen/patient_home_todo.dart';

import '../../theme.dart';
import 'doctor_home_todo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodoHome extends StatefulWidget {
   const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
     Tab(
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.my_notes,
          style: const TextStyle(
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

        child:  Text(
          AppLocalizations.of(context)!.doctor_notes,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Candara',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
