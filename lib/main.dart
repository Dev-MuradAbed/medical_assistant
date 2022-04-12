import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_assistant/screen/auth/change_password.dart';
import 'package:medical_assistant/screen/auth/forget_screen.dart';
import 'package:medical_assistant/screen/home_news_screen.dart';

import 'package:medical_assistant/screen/home_screen.dart';
import 'package:medical_assistant/screen/auth/login_screen.dart';
import 'package:medical_assistant/screen/map_pat_screen.dart';

import 'package:medical_assistant/screen/auth/sginup_screen.dart';
import 'package:medical_assistant/screen/todo_screen/patint_todo.dart';

import 'db/db_helper.dart';
import 'screen/lunch_screen.dart';
import 'screen/todo_screen/home_page.dart';
import 'services/theme_services.dart';
import 'todo_them/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DBHelper.initDB();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MedicalAssist()));
}

class MedicalAssist extends StatelessWidget {
  const MedicalAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      debugShowCheckedModeBanner: false,
       home:   const HomePage(),
      //initialRoute: '/lunch_screen',
      routes: {
        // '/lunch_screen':(context) =>  Search(),
        '/lunch_screen': (context) => const LunchScreen(),

        '/login_screen': (context) => const LoginScreen(),

        '/home_screen': (context) => const HomeScreen(),

        '/signup_screen': (context) => const SignupScreen(),

        '/forget_screen': (context) => const ForgetScreen(),

        '/change_password': (context) => const ChangePassword(),

        // '/change_password':(context) => const ChangePassword(),
      },
    );
  }
}
