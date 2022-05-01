import 'geometry.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Place{
  late String? name;
  late num? rating;
  late num? userRatingCount;
  late String? vicinity;
  late Geometry? geometry;

  Place(
      { this.name,
       this.rating,
       this.userRatingCount,
       this.vicinity,
       this.geometry});

  factory Place.fromJson(Map<dynamic, dynamic> parsedJson,) {
    return Place(
      name: parsedJson['name'],
      geometry: Geometry.fromJson(parsedJson['geometry']),
      rating: parsedJson['rating'] ?? 0.0,
      vicinity: parsedJson['vicinity'],
      userRatingCount: parsedJson['user_ratings_total'] ?? 0.0,
      // icon: icon
    );
  }
}