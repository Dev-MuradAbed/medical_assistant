import 'package:geolocator/geolocator.dart';
class GeoLocator{
  Future<Position> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  Future<double> getDist(double startLatitude, double startLongitude, double endLatitude,
      double endLongitude) async {
    return    Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}