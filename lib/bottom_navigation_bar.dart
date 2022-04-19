import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:medical_assistant/them.dart';
class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}
class _bottomNavigationBarState extends State<bottomNavigationBar> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final items = [
    const Icon(Icons.home)
  ];
  final screens = [];
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
              color: greenClr,
              height: 60,
              items: items,
              index: index,
              onTap: (index) {
                setState(() => this.index = index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
