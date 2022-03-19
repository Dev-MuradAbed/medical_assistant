import 'package:medical_assistant/Models/directions_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'dart:convert'as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';
class DirectionsRepository{
  static const _baseUrl ='https://maps.googleapis.com/maps/api/directions/json?';
Future<Direction>getDirections({required LatLng origin,required LatLng destination,})async{
  final response=await http.get(Uri.parse(_baseUrl),headers: {
    'origin': '${origin.latitude},${origin.longitude}',
    'destination': '${destination.latitude},${destination.longitude}',
    'key': 'AIzaSyCpbK_5pts7uhrQJLxpu7N3-LzePoDOMqg',});
  if (response.statusCode == 200) {
    return Direction.fromMap( convert.jsonDecode(response.body));
  }
  return throw 'no response data';
}
}