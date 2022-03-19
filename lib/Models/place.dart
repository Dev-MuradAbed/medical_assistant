import 'geometry.dart';
class Place {
  const Place(
      {required this.name,
      required this.rating,
      required this.userRatingCount,
      required this.vicinity,
      required this.geometry});
  final String name;
  final num rating;
  final num userRatingCount;
  final String? vicinity;
  final Geometry geometry;
  factory Place.fromJson(Map<dynamic, dynamic> parsedJson){
    return Place(
      name: parsedJson['name'],
      geometry: Geometry.fromJson(parsedJson['geometry']),
      rating: parsedJson['rating'] ?? 0.0,
      vicinity: parsedJson['vicinity'],
      userRatingCount: parsedJson['user_ratings_total'] ?? 0.0,
    );
  }
}
