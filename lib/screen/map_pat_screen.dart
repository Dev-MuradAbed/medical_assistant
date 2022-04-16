import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_assistant/api/marker.dart';
import 'package:medical_assistant/them.dart';
import 'package:provider/provider.dart';

import '../api/geolocator.dart';
import '../api/places.dart';
import '../models/place.dart';

class MapPatScreen extends StatefulWidget {
  const MapPatScreen({Key? key}) : super(key: key);

  @override
  State<MapPatScreen> createState() => _MapPatScreenState();
}

class _MapPatScreenState extends State<MapPatScreen> {
  final geoServise = GeoLocator();
  final markerServise = Markersa();
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
                  future: PlaceS().getPlaces(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                initialCameraPosition: const CameraPosition(
                                    target: LatLng(
                                        31.426028984666445, 34.380744928859755),
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
                          Container(
                              height: 40,
                              padding: const EdgeInsetsDirectional.only(
                                start: 20,
                                top: 10,
                              ),
                              alignment: AlignmentDirectional.topStart,
                              child: const Text(
                                "Nearby Hospitals",
                                style: TextStyle(
                                    fontSize: 20,
                                    // height: 10,
                                    fontFamily: 'Candara',
                                    color: blueClr),
                              )),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.separated(
                                  padding: const EdgeInsets.only(top: 0),
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder: (_, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemBuilder: (_, index) {
                                    return FutureProvider(
                                      create: (context) => geoServise.getDist(
                                          currentPosition.latitude,
                                          currentPosition.longitude,
                                          snapshot.data![index].geometry
                                              .location.lat,
                                          snapshot.data![index].geometry
                                              .location.lng),
                                      initialData: [],
                                      child: Card(
                                        child: ListTile(
                                          leading: SvgPicture.asset(
                                              'assets/images/hospital.svg'),
                                          title: Text(
                                            snapshot.data![index].name
                                                .toString(),
                                            style: const TextStyle(
                                              color: greenClr,
                                              fontFamily: 'Candara',
                                            ),
                                          ),
                                          subtitle: Consumer<double?>(
                                            builder: (context, km, widget) {
                                              shortlattude = snapshot.data![0]
                                                  .geometry.location.lat;
                                              shortlongtude = snapshot
                                                  .data![0]
                                                  .geometry
                                                  .location
                                                  .lng;
                                              return (km != null)
                                                  ? Row(
                                                      children: [
                                                        ((snapshot
                                                                    .data![
                                                                        index]
                                                                    .vicinity !=
                                                                null)
                                                            ? Text(
                                                                '${snapshot.data![index].vicinity} \u00b7 ',
                                                                style:
                                                                    const TextStyle(
                                                                  color:
                                                                      blackClr,
                                                                  fontFamily:
                                                                      'Candara',
                                                                ),
                                                              )
                                                            : const Text(
                                                                'No clear address')),
                                                        const Spacer(),
                                                        Text(
                                                          "${(km / 1000).toStringAsFixed(1)} km",
                                                          style:
                                                              const TextStyle(
                                                            color: greenClr,
                                                            fontFamily:
                                                                'Candara',
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : Container();
                                            },
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(
                                              Icons.directions,
                                              color: greenClr,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              : const Center(
                  child: const CircularProgressIndicator(),
                )),
    );
  }

  void setPolyline(
      {required double startlatitude,//خط طول نقطة البداية
      required double startlongitude,//خط عرض نقطة البداية
      required double endlatitude,//خط طول نقطة النهاية
      required double endlongitude//خط عرض نقطة النهاية
      }) async {
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      'AIzaSyCpbK_5pts7uhrQJLxpu7N3-LzePoDOMqg',
      PointLatLng(startlatitude, startlongitude),
      PointLatLng(endlatitude, endlongitude),
    );
    if (result.status == 'OK') {
      result.points.forEach((point) {
        setState(() {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));

        });
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
