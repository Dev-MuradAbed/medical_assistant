import 'location.dart';
class Geometry{
  late Location? location;
  Geometry({ this.location});
  Geometry.fromJson(Map<dynamic,dynamic>parsedJson):
        location = Location.fromJson(parsedJson['location']);
}