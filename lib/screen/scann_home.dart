import 'package:flutter/material.dart';
import 'package:medical_assistant/read_camera.dart';

import '../theme.dart';

class HomeScanned extends StatefulWidget {
  const HomeScanned({Key? key}) : super(key: key);

  @override
  State<HomeScanned> createState() => _HomeScannedState();
}

class _HomeScannedState extends State<HomeScanned> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Text(
                'Medical examinations',
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Candara',
                    fontSize: 20,
                    color: blueClr),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                       print(selectedIndex);

                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: selectedIndex==index?Color(0XFF19A049): const Color(0XFFF3F3F3),
                      ),
                      child:
                      ListTile(
                        title: Text(
                          index==0?'Blood Pressure':index==1?'Heart Rate':'Medical Records',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,color: Colors.black, fontSize: 11, fontFamily: 'Candara'),
                        ),
                        trailing:index==0
                            ?  Icon(Icons.favorite,color: selectedIndex==index?white:greenClr)
                            : index==1
                            ? Icon(Icons.monitor_heart_rounded,color: selectedIndex==index?white:greenClr)
                            : Icon(Icons.list_alt_sharp,color: selectedIndex==index?white:greenClr),
                        subtitle:  Text(
                         index==0?'120/80 mmHg':index==1?'74 bpm':'120/80mmHg/74bpm'
                          ,style:  TextStyle(
                              color: selectedIndex==index?white:greenClr,
                              fontSize: 9,
                              fontFamily: 'Candara',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

