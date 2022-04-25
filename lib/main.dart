import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_assistant/provider/result_provider.dart';
import 'package:medical_assistant/provider/todo_provider/todo_doctor_provider.dart';
import 'package:medical_assistant/provider/todo_provider/todo_patient_provider.dart';
import 'package:medical_assistant/screen/auth/forget_password.dart';
import 'package:medical_assistant/screen/auth/login_screen.dart';
import 'package:medical_assistant/screen/auth/sginup_screen.dart';
import 'package:medical_assistant/screen/lunch_screen.dart';
import 'package:medical_assistant/screen/profile_screen.dart';
import 'package:medical_assistant/screen/scann_home.dart';
import 'package:medical_assistant/theme.dart';
import 'package:provider/provider.dart';
import 'api/geolocator.dart';
import 'api/places.dart';
import 'bottom_navigation_bar.dart';
import 'database/patient_db.dart';
import 'models/place.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DbController().initDatabase();
  // await DbDoctorController().initDatabase();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MedicalAssist());
}

class MedicalAssist extends StatelessWidget {
  final locatorService = GeoLocator();
  final placesService = PlaceS();

  MedicalAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        FutureProvider(
          create: (context) => locatorService.getLocation(),
          initialData: null,
        ),
        FutureProvider(
          create: (context) {
            ImageConfiguration configuration =
            createLocalImageConfiguration(context);
            return BitmapDescriptor.fromAssetImage(
                configuration, 'assets/hospital.png');
          },
          initialData: null,
        ),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            print('main result ${position.latitude},${position.longitude}');
            return placesService.getPlaces(
              latt: position.latitude,
              lngt: position.longitude,
            );
          },
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (context) => TaskProvider(),
        ),
        ChangeNotifierProvider<TaskDoctorProvider>(
          create: (context) => TaskDoctorProvider(),
        ),
        ChangeNotifierProvider<ResultProvider>(
          create: (context) => ResultProvider(),
        ),
      ],
      child: MaterialApp(
        theme: Themes.light,
       // home:const ListResult(),
        darkTheme: Themes.dark,

        // themeMode: ThemeServices().theme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/lunch_screen',
        routes: {
          // '/lunch_screen':(context) =>  Search(),
          '/lunch_screen': (context) => const LunchScreen(),
          '/profile_screen': (context) => const ProfileScreen(),
          '/login_screen': (context) => const LoginScreen(),
          // '/home_screen': (context) => const HomeScreen(),
          '/signup_screen': (context) => const SignupScreen(),
          '/forget_screen': (context) => const ForgetPassword(),
          // '/change_password': (context) => const ChangePassword(),
        },
      ),
    );
  }
}
