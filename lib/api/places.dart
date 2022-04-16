import 'package:http/http.dart'as http;
import 'dart:convert'as convert;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
class PlaceS{
  final key = 'AIzaSyCpbK_5pts7uhrQJLxpu7N3-LzePoDOMqg';
  PlaceS();
  Future<List<Place>> getPlaces({required double latt,required double lngt}) async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latt,$lngt&type=hospital&rankby=distance&key=$key'));
    print('link$latt');
    print('link$lngt');
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var jsonResults = json['results'] as List;
      print('test$latt');
      print('test$lngt');
      return jsonResults.map((e) => Place.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Place');
    }
  }

}