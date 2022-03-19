
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Models/place.dart';
import '../../apis/geolocator_service.dart';
import '../../apis/marker_service.dart';
import '../../apis/places_services.dart';
class MapPatient extends StatefulWidget {
  const MapPatient({Key? key}) : super(key: key);

  @override
  State<MapPatient> createState() => _MapPatientState();
}

class _MapPatientState extends State<MapPatient> {
  final geoServise = GeoLocatorServise();
  final markerServise = MarkerServise();
  List<Marker> marke = [];
  final Set<Polyline> _Polyline = {};
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
    return FutureProvider(create: (_)=>placesProvider, initialData: [],
    child: Scaffold(
      backgroundColor: Colors.grey[100],
      body: (currentPosition != null)
          ? FutureBuilder<List<Place>>(
        future:
        PlacesService().getPlaces(
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
                const SizedBox(height: 35,),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
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
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                      // itemCount: snapshot.data!.length,
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
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              margin:  EdgeInsets.only(top: 20),
                              width: double.infinity,
                              // height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(10, 10),
                                        color: Colors.black26
                                        ,
                                        blurRadius: 20),
                                    BoxShadow(
                                        offset: const Offset(-10, -10),
                                        color: Colors.white.withOpacity(0.85),
                                        blurRadius: 10)
                                  ]),
                              child:ListTile(
                                title: Align(
                                  alignment: Alignment.centerLeft
                                    ,
                                child: Text("Gaza")),
                                subtitle:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text("lllllllllllllll"),
                                    Text("30km"),
                                    IconButton(onPressed: (){}, icon:Icon (Icons.directions,color: Colors.purple.shade400,)),

                                  ],
                                ),

                                // title: Text(
                                //     snapshot.data![index].name
                                // ),
                                // subtitle: Column(
                                //   crossAxisAlignment:
                                //   CrossAxisAlignment.start,
                                //   children: [
                                //     const SizedBox(
                                //       height: 5.0,
                                //     ),
                                //     Consumer<double?>(
                                //       builder: (context, km, widget) {
                                //         shortlattude = snapshot.data![0]
                                //             .geometry.location.lat;
                                //         shortlongtude = snapshot
                                //             .data![0]
                                //             .geometry
                                //             .location
                                //             .lng;
                                //         return (km != null)
                                //             ? Column(
                                //           crossAxisAlignment:
                                //           CrossAxisAlignment
                                //               .start,
                                //           children: [
                                //             (snapshot.data![index]
                                //                 .vicinity !=
                                //                 "")
                                //                 ? Text(
                                //                 '${snapshot.data![index].vicinity} \u00b7 ')
                                //                 : const Text(
                                //                 'No clear address'),
                                //             // Text(
                                //             //     '${(km / 1609).round()} mi')
                                //             Text(
                                //                 "${(km / 1000).toStringAsFixed(1)} km"),
                                //           ],
                                //         )
                                //             : Container();
                                //       },
                                //     ),
                                //     const SizedBox(
                                //       height: 3.0,
                                //     )
                                //   ],
                                // ),
                                // trailing: IconButton(
                                //   icon: Icon(
                                //     Icons.directions,
                                //     color:
                                //     Theme.of(context).primaryColor,
                                //   ),
                                //   onPressed: () {},
                                // ),
                              ),
                            ),
                          ),
                          // child: Card(
                          //   child: ListTile(
                          //     title: Text( snapshot.data![index].name),
                          //     subtitle: Column(
                          //       crossAxisAlignment:
                          //       CrossAxisAlignment.start,
                          //       children: [
                          //         const SizedBox(
                          //           height: 5.0,
                          //         ),
                          //         Consumer<double?>(
                          //           builder: (context, km, widget) {
                          //             shortlattude = snapshot.data![0]
                          //                 .geometry.location.lat;
                          //             shortlongtude = snapshot
                          //                 .data![0]
                          //                 .geometry
                          //                 .location
                          //                 .lng;
                          //             return (km != null)
                          //                 ? Column(
                          //               crossAxisAlignment:
                          //               CrossAxisAlignment
                          //                   .start,
                          //               children: [
                          //                 (snapshot.data![index]
                          //                     .vicinity !=
                          //                     "")
                          //                     ? Text(
                          //                     '${snapshot.data![index].vicinity} \u00b7 ')
                          //                     : const Text(
                          //                     'No clear address'),
                          //                 // Text(
                          //                 //     '${(km / 1609).round()} mi')
                          //                 Text(
                          //                     "${(km / 1000).toStringAsFixed(1)} km"),
                          //               ],
                          //             )
                          //                 : Container();
                          //           },
                          //         ),
                          //         const SizedBox(
                          //           height: 3.0,
                          //         )
                          //       ],
                          //     ),
                          //     trailing: IconButton(
                          //       icon: Icon(
                          //         Icons.directions,
                          //         color:
                          //         Theme.of(context).primaryColor,
                          //       ),
                          //       onPressed: () {},
                          //     ),
                          //   ),
                          // ),
                        );
                      }),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
          : const Center(
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
