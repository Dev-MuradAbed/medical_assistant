import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/read_camera.dart';

import '../boold.dart';
import '../theme.dart';
import 'list_result.dart';

class HomeScanned extends StatefulWidget {
  const HomeScanned({Key? key}) : super(key: key);

  @override
  State<HomeScanned> createState() => _HomeScannedState();
}

class _HomeScannedState extends State<HomeScanned>with SingleTickerProviderStateMixin {

  final List<Tab> tabs = <Tab>[
    Tab(child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('Boold Perssure',style: TextStyle(fontSize: 14),),
              SizedBox(width: 30,),
              Icon(Icons.favorite, color: Colors.black,),
            ],
          ),
          const Text('200/100 mmhg', style: TextStyle(fontSize: 12, color: Colors.black),),
        ],
      ),
    ),),
    Tab(

      child: Center(
      child: Container(child: Column(
        children: [
          Row(
            children: const [
              Text('Pluse Rate',style: TextStyle(fontSize: 14),),
              SizedBox(width: 30,),
              Icon(Icons.favorite, color: Colors.black,),
            ],
          ),
          const Text('74 bpm', style: TextStyle(fontSize: 12, color: Colors.black),),
        ],
      ),),
    ),),
    Tab(child: Center(
      child: Column(
        children: [
          Row(
            children: const [
              Text('medical record',style: TextStyle(fontSize: 14),),
              SizedBox(width: 30,),
              Icon(Icons.favorite, color: Colors.black,),
            ],
          ),
          const Text('200/100 mmhg / 74 bpm', style: TextStyle(fontSize: 12, color: Colors.black),),
        ],
      ),
    ),),

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
        toolbarHeight: 80,
        excludeHeaderSemantics: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Medical examinations',style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Candara',
                      fontSize: 20,
                      color: blueClr),
      ),
        bottom: TabBar(


         labelPadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
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
      body:  TabBarView(
        controller: _tabController,
        children:const [
          BloodRate(),
          PlusRate(),
          ListResult(),
        ],
      ),
      // body: SafeArea(
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(
      //       horizontal: 25,
      //     ),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children:  [
      //         const Text(
      //           'Medical examinations',
      //           style:  TextStyle(
      //               fontWeight: FontWeight.bold,
      //               fontFamily: 'Candara',
      //               fontSize: 20,
      //               color: blueClr),
      //         ),
      //         const SizedBox(height: 20),
      //         SingleChildScrollView(
      //           scrollDirection: Axis.horizontal,
      //           child: Row(
      //             children: List.generate(3, (index) => GestureDetector(
      //               onTap: () {
      //                 setState(() {
      //                   selectedIndex = index;
      //                  print(selectedIndex);
      //
      //                 });
      //               },
      //               child: Container(
      //                 margin: const EdgeInsets.only(right: 10),
      //                 width: 160,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(25),
      //                   color: selectedIndex==index?Color(0XFF19A049): const Color(0XFFF3F3F3),
      //                 ),
      //                 child:
      //                 ListTile(
      //                   title: Text(
      //                     index==0?'Blood Pressure':index==1?'Heart Rate':'Medical Records',
      //                     style: const TextStyle(
      //                         fontWeight: FontWeight.bold,color: Colors.black, fontSize: 11, fontFamily: 'Candara'),
      //                   ),
      //                   trailing:index==0
      //                       ?  Icon(Icons.favorite,color: selectedIndex==index?white:greenClr)
      //                       : index==1
      //                       ? Icon(Icons.monitor_heart_rounded,color: selectedIndex==index?white:greenClr)
      //                       : Icon(Icons.list_alt_sharp,color: selectedIndex==index?white:greenClr),
      //                   subtitle:  Text(
      //                    index==0?'120/80 mmHg':index==1?'74 bpm':'120/80mmHg/74bpm'
      //                     ,style:  TextStyle(
      //                         color: selectedIndex==index?white:greenClr,
      //                         fontSize: 9,
      //                         fontFamily: 'Candara',
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //               ),
      //             )),
      //           ),
      //         ),
      //         Expanded(
      //           child: ListView(
      //             children: [
      //               selectedIndex==0?BloodRate():selectedIndex==1?PlusRate():ListResult(),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

