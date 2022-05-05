import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../provider/DoctorProviderfire.dart';
import '../provider/profile_provider.dart';
import '../provider/result_provider.dart';
import '../provider/todo_provider/todo_doctor_provider.dart';
import '../provider/todo_provider/todo_patient_provider.dart';
import '../s.dart';
import '../screen/auth/forget_password.dart';
import '../screen/auth/login_screen.dart';
import '../screen/auth/sginup_screen.dart';
import '../screen/lunch_screen.dart';
import '../storge/pref_controller.dart';
import '../theme.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_bar.dart';
import 'database/patient_db.dart';
import 'map/models/place.dart';
import 'map/services/geolocator_service.dart';
import 'map/services/places.dart';
import 'provider/provider_language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';





Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPrefController().initPref();
  await DbController().initDatabase();
  customErroerScreens();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MedicalAssist());
}

class MedicalAssist extends StatelessWidget {
  final locatorService = GeoLocatorServise();
  final placesService = PlacesService();

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
                latt: position.latitude, lngt: position.longitude);
          },
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (context) => TaskProvider(),
        ),
        ChangeNotifierProvider<TaskDoctorProvider>(
          create: (context) => TaskDoctorProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider<ResultProvider>(
          create: (context) => ResultProvider(),
        ),
        ListenableProvider<DoctorProviderfire>(
            create: (_) => DoctorProviderfire()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider()),
      ],
      child: mati(),
    );
  }
}
class mati extends StatefulWidget {
  const mati({Key? key}) : super(key: key);

  @override
  State<mati> createState() => _matiState();
}

class _matiState extends State<mati> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
      AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(Provider.of<LanguageProvider>(context).language),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],

      theme: Themes.light,
      darkTheme: Themes.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: '/lunch_screen',
      routes: {
        '/lunch_screen': (context) => const LunchScreen(),
        '/button_navigator_bar': (context) => const BNBar(),
        '/login_screen': (context) => const LoginScreen(),
        '/signup_screen': (context) => const SignupScreen(),
        '/forget_screen': (context) => const ForgetPassword(),
        // '/change_password': (context) => const ChangePassword(),
      },
    );
  }
}

