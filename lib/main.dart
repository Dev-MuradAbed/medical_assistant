import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_assistant/Screens/Auth/login_screen.dart';
import 'package:medical_assistant/Screens/Auth/sginup_screen.dart';
import 'package:medical_assistant/Screens/Patient/Map_patient.dart';
import 'Models/place.dart';
import 'Screens/Auth/changePassword_Screen.dart';
import 'Screens/Auth/passwordRecovery.dart';
import 'package:provider/provider.dart';

import 'apis/geolocator_service.dart';
import 'apis/places_services.dart';
void main()=>runApp( MyApp());
class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorServise();
  final placesService = PlacesService();


  @override
  Widget build(BuildContext context) {
    return  MultiProvider(providers: [
      FutureProvider(create: (context)=>locatorService.getLocation(), initialData: null)
      ,FutureProvider(
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
      )
    ],
child:
      MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPatient(),
    ));
  }
}
