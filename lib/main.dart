

import 'package:flutter/material.dart';
import 'package:medical_assistant/screen/login_screen%5D.dart';

import 'screen/lunch_screen.dart';

void main(){
  runApp(const MedicalAssist());
}

class MedicalAssist extends StatelessWidget {
  const MedicalAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/lunch_screen',
      routes: {
        '/lunch_screen':(context) => const LunchScreen(),
        '/login_screen':(context) => const LoginScreen(),

      },
    );
  }
}



