
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MarkerServise {
  List<Marker> getMarkers(List<Place>? places) {
    List<Marker> markers = [];
    places!.forEach((Place) {
      Marker marker = Marker(
          markerId: MarkerId(Place.name),
          draggable: false,

          infoWindow: InfoWindow(
            title: Place.name,
            snippet: Place.vicinity,
          ),
          position:
              LatLng(Place.geometry.location.lat, Place.geometry.location.lng));
      markers.add(marker);
    });

    return markers;
  }
}
