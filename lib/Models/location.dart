class Location {
  const Location(this.lat, this.lng);
  final double lat;
  final double lng;

  Location.fromJson(Map<dynamic, dynamic> parsedJson)
      : lat = parsedJson['lat'],
        lng = parsedJson['lng'];
}
