import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:medical_assistant/read_camera.dart';
import 'package:medical_assistant/screen/home_news_screen.dart';
import 'package:medical_assistant/screen/map_pat_screen.dart';
import 'package:medical_assistant/screen/news_details.dart';
import 'package:medical_assistant/screen/profile_screen.dart';
import 'package:medical_assistant/screen/todo_screen/patient_todo_screen/home_page.dart';
import 'package:medical_assistant/them.dart';

class BNBar extends StatefulWidget {
  const BNBar({Key? key}) : super(key: key);

  @override
  _BNBarState createState() => _BNBarState();
}

class _BNBarState extends State<BNBar> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final item = const[
    Icon(Icons.person, size: 26, color: whitClr),
    Icon(Icons.location_on, size: 26, color: whitClr),
    Icon(Icons.library_books_outlined, size: 26, color: whitClr),
    Icon(Icons.favorite, size: 26, color:whitClr ),
    Icon(Icons.event_note_outlined, size: 26, color: whitClr)
  ];
  final screens = const [
    ProfileScreen(),
    MapPatScreen(),
    HomeNewsScreen(),
    PlusRate(),
    HomePage(),
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
            body: screens[index],
            bottomNavigationBar: CurvedNavigationBar(
              key: navigationKey,
              backgroundColor: Colors.transparent,
              color: Colors.green.shade500,
              height: 55,
              items:item,
              index: index,
              onTap: (index) {
                setState(() => this.index = index);
              },
              //  letIndexChange: ,
            ),
          ),
        ),
      ),
    );
  }
}
