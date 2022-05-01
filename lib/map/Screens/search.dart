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

    print('${currentPosition.latitude}');
    print('${currentPosition.longitude}');

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
                    print('the set${Set<Marker>.of(markers)}');

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
                                  // controller.setMapStyle(Utils.mapStyle);
                                  // setPolylines();
                                  setPolyline(
                                      startlatitude: currentPosition.latitude,
                                      startlongitude: currentPosition.longitude,
                                      endlatitude: shortlattude,
                                      endlongitude: shortlongtude);
                                }),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                // itemCount: PlacesService().getPlaces().,
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
                                            '${snapshot.data![index].name}'),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [

                                            SizedBox(
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
                                                              : Text(
                                                                  'No clear address'),
                                                          // Text(
                                                          //     '${(km / 1609).round()} mi')
                                                          Text(
                                                              "${(km / 1000).toStringAsFixed(1)} km"),
                                                        ],
                                                      )
                                                    : Container();
                                              },
                                            ),
                                            SizedBox(
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
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  // void _launchMapUrl({required double lat, required double lng}) async {
  //   final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

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
            polylineId: PolylineId('polyline'),
            width: 5,
            color: Colors.blue,
            points: polylineCoordinates));
      });
    }
  }

//   void setPolylines() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         "c",
//         PointLatLng(31.425116, 34.38021),
//         PointLatLng(31.420637, 34.359642));
//       print('noooooooooooooooo${result.status}');

//     if (result.status == "OK") {
//       print('yesssssssssssssssss');
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//       setState(() {
//         Polyline(
//             width: 10,
//             polylineId: PolylineId('polyline'),
//             color: Colors.green,
//             points: polylineCoordinates);
//       });
//     }
//   }
// }
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
