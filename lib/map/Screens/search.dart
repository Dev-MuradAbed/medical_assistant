import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_assistant/map/services/places.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import '../models/place.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../services/geolocator_service.dart';
import '../services/marker_service.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final geoServise = GeoLocatorServise();
  final markerServise = MarkerServise();
  List<Marker> marke = [];
  Set<Polyline> _Polyline = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  double short = 10;
  double shortlattude = 31.420637;
  double shortlongtude = 34.359642;

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    ImageConfiguration configuration = createLocalImageConfiguration(context);


    return FutureProvider(
        create: (_) => placesProvider,
        initialData: [],
        child: Scaffold(
          body: (currentPosition != null)
              ? FutureBuilder<List<Place>>(
                  future: PlacesService().getPlaces(
                    latt: currentPosition.latitude,
                    lngt: currentPosition.longitude,
                  ),
                  builder: (context, snapshot) {
                    var markers = (snapshot.data != null)
                        ? markerServise.getMarkers(snapshot.data)
                        : marke;


                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height *0.67,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(currentPosition.latitude,
                                        currentPosition.longitude),
                                    zoom: 16.0),
                                zoomGesturesEnabled: true,
                                markers: Set<Marker>.of(markers),
                                polylines: _Polyline,
                                onMapCreated: (controller) {

                                  setPolyline(
                                      startlatitude: currentPosition.latitude,
                                      startlongitude: currentPosition.longitude,
                                      endlatitude: shortlattude,
                                      endlongitude: shortlongtude);
                                }),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) {
                                  return FutureProvider(
                                    create: (context) => geoServise.getDist(
                                        currentPosition.latitude,
                                        currentPosition.longitude,
                                        snapshot
                                            .data![index].geometry.location.lat,
                                        snapshot.data![index].geometry.location
                                            .lng),
                                    initialData: null,
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index].name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [

                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Consumer<double?>(
                                              builder: (context, km, widget) {
                                                shortlattude = snapshot.data![0]
                                                    .geometry.location.lat;
                                                shortlongtude = snapshot
                                                    .data![0]
                                                    .geometry
                                                    .location
                                                    .lng;
                                                return (km != null)
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          (snapshot.data![index]
                                                                      .vicinity !=
                                                                  "")
                                                              ? Text(
                                                                  '${snapshot.data![index].vicinity} \u00b7 ')
                                                              : const Text(
                                                                  'No clear address'),

                                                          Text(
                                                              "${(km / 1000).toStringAsFixed(1)} km"),
                                                        ],
                                                      )
                                                    : Container();
                                              },
                                            ),
                                            const SizedBox(
                                              height: 3.0,
                                            )
                                          ],
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.directions,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: const CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : const Center(
                  child: const CircularProgressIndicator(),
                ),
        ));
  }


  void setPolyline(
      {required double startlatitude,
      required double startlongitude,
      required double endlatitude,
      required double endlongitude}) async {
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      'AIzaSyCpbK_5pts7uhrQJLxpu7N3-LzePoDOMqg',
      PointLatLng(startlatitude, startlongitude),
      PointLatLng(endlatitude, endlongitude),
    );
    if (result.status == 'OK') {
      result.points.forEach((point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _Polyline.add(Polyline(
            polylineId: const PolylineId('polyline'),
            width: 5,
            color: Colors.blue,
            points: polylineCoordinates));
      });
    }
  }


}

class Utils {
  static String mapStyle = '''
  [
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
  ''';
  static String deviceSuffix(BuildContext context) {
    String deviceSuffix = '';
    TargetPlatform platform = Theme.of(context).platform;
    switch (platform) {
      case TargetPlatform.android:
        deviceSuffix = '_android';
        break;
      case TargetPlatform.iOS:
        deviceSuffix = '_ios';
        break;
      default:
        deviceSuffix = '';
    }
    return deviceSuffix;
  }
}
