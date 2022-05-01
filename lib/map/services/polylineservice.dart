import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineServise {
  Future<Polyline> drawPolyline(LatLng from, LatLng to) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyCpbK_5pts7uhrQJLxpu7N3-LzePoDOMqg',
        PointLatLng(from.latitude, from.longitude),
        PointLatLng(to.latitude, to.longitude));
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    _calcDistance(polylineCoordinates);
    return Polyline(
        polylineId: PolylineId("Polyline_id${result.points.length}"),
        color: Colors.blue,
        points: polylineCoordinates);
  }

  void distanceBetween(List<LatLng> polylineCoordinates) {
    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordineCoordinates(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
     print ("distance = =============================================${totalDistance.toStringAsFixed(2)} km");
  }

  void _calcDistance(List<LatLng> polylineCoordinates) {
    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordineCoordinates(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    print(
        "distance = =============================================${totalDistance.toStringAsFixed(2)} km");
  }

  double _coordineCoordinates(lat1, lng1, lat2, lng2) {
    var p = 0.0174532925119943295;
    var c = cos;
    var a = 0.5;
    c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
