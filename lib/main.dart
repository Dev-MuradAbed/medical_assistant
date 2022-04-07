

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_assistant/screen/checkForecode.dart';
import 'package:medical_assistant/screen/home_screen.dart';
import 'package:medical_assistant/screen/login_screen.dart';
import 'package:medical_assistant/screen/sginuo_screen.dart';

import 'screen/lunch_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MedicalAssist());
}

class MedicalAssist extends StatelessWidget {
  const MedicalAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/lunch_screen',
      routes: {
        '/lunch_screen':(context) => const CodeFore(),
        '/login_screen':(context) => const LoginScreen(),
        '/home_screen':(context) => const HomeScreen(),
        '/signup_screen':(context) => const SignupScreen(),

      },
    );
  }
}



