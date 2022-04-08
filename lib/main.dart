

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_assistant/screen/change_password.dart';
import 'package:medical_assistant/screen/forget_screen.dart';
import 'package:medical_assistant/screen/home_news.dart';
import 'package:medical_assistant/screen/home_screen.dart';
import 'package:medical_assistant/screen/login_screen.dart';
import 'package:medical_assistant/screen/map_pat_screen.dart';
import 'package:medical_assistant/screen/news_screen.dart';
import 'package:medical_assistant/screen/sginup_screen.dart';

import 'screen/lunch_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MedicalAssist());
}

class MedicalAssist extends StatelessWidget {
  const MedicalAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home:  HomePage(),
     // initialRoute: '/lunch_screen',
      routes: {
        // '/lunch_screen':(context) =>  Search(),
        '/lunch_screen':(context) => const MapPatScreen(),
        '/login_screen':(context) => const LoginScreen(),
        '/home_screen':(context) => const HomeScreen(),
        '/signup_screen':(context) => const SignupScreen(),
        '/forget_screen':(context) => const ForgetScreen(),
        '/change_password':(context) => const ChangePassword(),
       // '/change_password':(context) => const ChangePassword(),

      },
    );
  }
}



