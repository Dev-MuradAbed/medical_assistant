
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/place.dart';

class PlacesService {
  final key = 'AIzaSyCpbK_5pts7uhrQJLxpu7N3-LzePoDOMqg';
  PlacesService();

  Future<List<Place>> getPlaces({required double latt,required double lngt}) async {
 

    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latt,$lngt&type=hospital&rankby=distance&key=$key'));

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var jsonResults = json['results'] as List;

      return jsonResults.map((e) => Place.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Place');
    }

  }
}
