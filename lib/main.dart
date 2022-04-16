

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medical_assistant/read_camera.dart';
import 'package:medical_assistant/screen/auth/change_password.dart';
import 'package:medical_assistant/screen/auth/forget_password.dart';
import 'package:medical_assistant/screen/auth/login_screen.dart';
import 'package:medical_assistant/screen/auth/sginup_screen.dart';
import 'package:medical_assistant/screen/home_screen.dart';
import 'package:medical_assistant/screen/profile_screen.dart';
import 'package:medical_assistant/screen/todo_screen/doctor_todo_screen/doctor_task.dart';
import 'package:medical_assistant/services/theme_services.dart';
import 'package:medical_assistant/todo_them/theme.dart';
import 'package:provider/provider.dart';
import 'api/geolocator.dart';
import 'api/places.dart';
import 'db/result_db/result_db.dart';
import 'db/todo_db/patient_db.dart';
import 'db/todo_db/docotr_db.dart';
import 'screen/lunch_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DBHelper.initDB();
  await DoctorHelper.initDB();
  await ResultDbHelper.initDB();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp( ProviderScope(child:   MedicalAssist()));
}

class MedicalAssist extends StatelessWidget {
  final locatorService = GeoLocator();
  final placesService = PlaceS();
   MedicalAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

      ],

      child: GetMaterialApp(

        theme: Themes.light ,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        debugShowCheckedModeBanner: false,
        home:  const PlusRate(),
      // initialRoute: '/lunch_screen',
        routes: {
          // '/lunch_screen':(context) =>  Search(),
          '/lunch_screen':(context) => const LunchScreen(),
          '/profile_screen':(context) => const ProfileScreen(),
          '/login_screen':(context) => const LoginScreen(),
          '/home_screen':(context) => const HomeScreen(),
          '/signup_screen':(context) => const SignupScreen(),
          '/forget_screen':(context) => const ForgetPassword(),
          '/change_password':(context) => const ChangePassword(),
         // '/change_password':(context) => const ChangePassword(),

        },
      ),
    );
  }
}



