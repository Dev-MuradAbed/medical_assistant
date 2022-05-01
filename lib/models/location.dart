class Location {
 late  double lat;
  late double lng;

  Location({ this.lat=0.0,  this.lng=0.0});
  Location.fromJson(Map<dynamic, dynamic> parsedJson)
      : lat = parsedJson['lat'],
        lng = parsedJson['lng'];
}
