import 'package:flutter/material.dart';
import 'package:medical_assistant/Screens/Auth/login_screen.dart';
import 'package:medical_assistant/Screens/Auth/sginup_screen.dart';

import 'Screens/Auth/changePassword_Screen.dart';
import 'Screens/Auth/passwordRecovery.dart';
void main()=>runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangePassword_Screen(),
    );
  }
}
