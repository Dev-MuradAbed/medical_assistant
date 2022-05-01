import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Directions {
  late LatLngBounds? bounds;
  late List<PointLatLng>? polylinePoint;
  late String? totalDistance;
  late String? totalDuration;

  Directions(
      {this.bounds,
      this.polylinePoint,
      this.totalDistance,
      this.totalDuration});
  factory Directions.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty)
      return throw 'You don\'t have any data';
    final data = Map<String, dynamic>.from(map['routes'][0]);
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
        southwest: LatLng(southwest['lat'], southwest['lng']),
        northeast: LatLng(northeast['lat'], northeast['lng']));
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }
    return Directions(
        bounds: bounds,
        polylinePoint: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        totalDistance: distance,
        totalDuration: duration);
  }
}
