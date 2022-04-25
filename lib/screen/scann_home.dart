import 'package:flutter/material.dart';
import 'package:medical_assistant/provider/result_provider.dart';
import 'package:medical_assistant/read_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../boold.dart';
import '../theme.dart';

import 'list_result.dart';

class HomeScanned extends StatefulWidget {
  const HomeScanned({Key? key}) : super(key: key);

  @override
  State<HomeScanned> createState() => _HomeScannedState();
}

class _HomeScannedState extends State<HomeScanned>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(
      child: Center(
        child: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    'Boold Perssure',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                ],
              ),
              Text(
                Provider.of<ResultProvider>(context, listen: false)
                    .resultList
                    .last
                    .sy !=
                    null
                    ? '${Provider.of<ResultProvider>(context).resultList.last.sy}/${Provider.of<ResultProvider>(context).resultList.last.dy} mmHg'
                    : '120/100 mmHg',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        }),
      ),
    ),
    Tab(
      child: Center(
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Plus Rate',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ],
            ),
            Text(
              '',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    ),
    Tab(
      child: Center(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'medical record',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                  ],
                ),
                 Text(
                   '${Provider.of<ResultProvider>(context).resultList.last.sy??'120'}/${Provider.of<ResultProvider>(context).resultList.last.dy??'70'} mmHg / ${Provider.of<ResultProvider>(context).resultList.last.heartRate??'60'}',
                     // Provider.of<ResultProvider>(context, listen: false)
                     //     .resultList
                     //     .last
                     //     .sy !=
                     //     null
                     //     ? '${Provider.of<ResultProvider>(context).resultList.last.sy}/${Provider.of<ResultProvider>(context).resultList.last.dy} mmHg'
                     //     : '120/100 mmHg ',

                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            );
          }
        ),
      ),
    ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Provider.of<ResultProvider>(context, listen: false).getRecord();
    Permission.microphone.request();
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
        toolbarHeight: 80,
        excludeHeaderSemantics: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Medical examinations',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Candara',
              fontSize: 20,
              color: blueClr),
        ),
        bottom: TabBar(
          labelPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          controller: _tabController,
          tabs: tabs,
          indicatorColor: greenClr,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          isScrollable: true,
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            color: greenClr,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BloodRate(),
          PlusRate(),
          ListResult(),
        ],
      ),
    );
  }
}
