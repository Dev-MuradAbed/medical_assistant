import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:medical_assistant/read_camera.dart';
import 'package:medical_assistant/screen/home_news_screen.dart';
import 'package:medical_assistant/screen/map_pat_screen.dart';
import 'package:medical_assistant/screen/news_details.dart';
import 'package:medical_assistant/screen/profile_screen.dart';
import 'package:medical_assistant/screen/scann_home.dart';
import 'package:medical_assistant/screen/todo_screen/patient_home_todo.dart';
import 'package:medical_assistant/screen/todo_screen/todo_home.dart';
import 'package:medical_assistant/theme.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class BNBar extends StatefulWidget {
  const BNBar({Key? key}) : super(key: key);

  @override
  _BNBarState createState() => _BNBarState();
}

class _BNBarState extends State<BNBar> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int _index = 4;

  final item = const [
    Icon(Icons.person, size: 26, color: whitClr),
    Icon(Icons.location_on, size: 26, color: whitClr),
    Icon(Icons.library_books_outlined, size: 26, color: whitClr),
    Icon(Icons.favorite, size: 26, color: whitClr),
    Icon(Icons.event_note_outlined, size: 26, color: whitClr)
  ];
@override
  void initState() {
    super.initState();
    Permission.camera.request();
  }
  final screens = [
    ProfileScreen(),
    MapPatScreen(),
    HomeNewsScreen(),
    HomeScan(),
    TodoHome(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: greenClr,
      child: SafeArea(
        top: true,
        child: ClipRect(
          child: Scaffold(
            backgroundColor: Colors.white,
            extendBody: true,
            body: screens[_index],
            bottomNavigationBar: CurvedNavigationBar(
              key: navigationKey,
              backgroundColor: Colors.transparent,
              color: Colors.green.shade500,
              height: 55,
              items: item,
              index: _index,
              onTap: (index) {
                setState(() {
                  _index = index;
                });

                //   if(await Permission.camera.isGranted&&await Permission.location.isGranted&&await Permission.microphone.isGranted){
                //     setState(() {
                //       _index = index;
                //     });
                //   }else {
                //     await  Permission.microphone.request();
                //     await Permission.camera.request();
                //     await Permission.location.request();
                //     if(await Permission.camera.isGranted){
                //       setState(() {
                //         _index = index;
                //       });
                //     }
                //
                //
                //     showToast("Provide Camera, Location and Microphone permission to use this app", position: ToastPosition.bottom);
                //   }
                //
                //   // _index = index;
                // });
                // setState(() => this.index = index);
              },
              //  letIndexChange: ,
            ),
          ),
        ),
      ),
    );
  }
}
