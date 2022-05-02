import 'package:flutter/material.dart';
import 'package:medical_assistant/provider/result_provider.dart';
import 'package:medical_assistant/read_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../boold.dart';
import '../theme.dart';

import 'list_result.dart';

class HomeScan extends StatefulWidget {
  const HomeScan({Key? key}) : super(key: key);

  @override
  State<HomeScan> createState() => _HomeScanState();
}

class _HomeScanState extends State<HomeScan>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
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

  List<Tab> tabs = <Tab>[
    Tab(
      child: Center(
        child: Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.37,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const[
                         Text(
                          'Blood Pressure',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                         SizedBox(width: 20),
                         Expanded(
                           child: Icon(
                            Icons.bloodtype_outlined,
                        ),
                         ),
                      ],
                    ),
                    const Text(
                      '120 / 60 mmHg',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }
        ),

      ),
    ),
    Tab(
      child: Center(
        child: Builder(builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.37,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Heart Rate',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Icon(
                        Icons.monitor_heart_outlined ,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '70 bmp',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }),
      ),
    ),
    Tab(
      child: Center(
        child: Builder(builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.37,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:const [
                    Text(
                      'Medical Record',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Icon(
                        Icons.topic_outlined,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '120/60 mmHg - 70 bmp',
                  // '${Provider.of<ResultProvider>(context).resultList.last.sy} / ${Provider.of<ResultProvider>(context).resultList.last.dy}',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }),
      ),
    ),
  ];
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
            labelPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            controller: _tabController,
            tabs: tabs,
            indicatorColor: greenClr,
            labelColor: Colors.white,
            unselectedLabelColor: blueClr,
            isScrollable: true,
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              color: greenClr,
            ),
          ),
        ),

            body: TabBarView(
              controller: _tabController,
              children: const[
                 BloodRate(),
                 PlusRate(),
                 ListResult(),
              ],
            )

    );
  }

// @override
// Widget build(BuildContext context) {

//   return Scaffold(
//     backgroundColor: Colors.white,
//     appBar: AppBar(
//       toolbarHeight: 80,
//       excludeHeaderSemantics: true,
//       backgroundColor: Colors.white,
//       elevation: 0,
//       title: const Text(
//         'Medical examinations',
//         style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Candara',
//             fontSize: 20,
//             color: blueClr),
//       ),
//       // bottom: TabBar(
//       //   labelPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//       //   controller: _tabController,
//       //   tabs: tabs,
//       //   indicatorColor: greenClr,
//       //   labelColor: Colors.black,
//       //   unselectedLabelColor: Colors.grey,
//       //   isScrollable: true,
//       //   indicator: BoxDecoration(
//       //     shape: BoxShape.rectangle,
//       //     borderRadius: BorderRadius.circular(50),
//       //     color: greenClr,
//       //   ),
//       // ),
//     ),
//     body:
//       Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text(
//             'Medical examinations',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Candara',
//                 fontSize: 20,
//                 color: blueClr),
//           ),
//         ),
//       )
//     // TabBarView(
//     //   controller: _tabController,
//     //   children: const [
//     //     BloodRate(),
//     //     PlusRate(),
//     //     ListResult(),
//     //   ],
//     // ),
//   );
// }
}