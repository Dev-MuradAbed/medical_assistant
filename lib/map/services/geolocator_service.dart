import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocatorServise {
  Future<Position> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<double> getDist(double startLatitude, double startLongitude, double endLatitude,
      double endLongitude) async {
 return await   Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  Future<double> getDistanceFromLatLonInKm(double startLatitude,
      double startLongitude, double endLatitude, double endLongitude) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(endLatitude - startLatitude); // deg2rad below
    var dLon = deg2rad(endLongitude - startLongitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(startLatitude)) *
            cos(deg2rad(endLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    dynamic d = R * c; // Distance in km
    return d;
  }

  deg2rad(deg) {
    return deg * (pi / 180);
  }
}
