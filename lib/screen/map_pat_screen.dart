// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:medical_assistant/api/places.dart';
//
// import 'dart:math' show cos, sqrt, asin;
//
// import 'package:provider/provider.dart';
//
// import '../api/geolocator.dart';
// import '../models/place.dart';
// import '../theme.dart';
//
// class MapView extends StatefulWidget {
//   @override
//   _MapViewState createState() => _MapViewState();
// }
//
// class _MapViewState extends State<MapView> {
//   CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
//   late GoogleMapController mapController;
//   late Position _currentPosition;
//   String _currentAddress = '';
//   final startAddressController = TextEditingController();
//   final destinationAddressController = TextEditingController();
//   final startAddressFocusNode = FocusNode();
//   final desrinationAddressFocusNode = FocusNode();
//   String _startAddress = '';
//   String _destinationAddress = '';
//   String? _placeDistance;
//   Set<Marker> markers = {};
//   late PolylinePoints polylinePoints;
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Widget _textField({
//     required TextEditingController controller,
//     required FocusNode focusNode,
//     required String label,
//     required String hint,
//     required double width,
//     required Icon prefixIcon,
//     Widget? suffixIcon,
//     required Function(String) locationCallback,
//   }) {
//     return Container(
//       width: width * 0.8,
//       child: TextField(
//         onChanged: (value) {
//           locationCallback(value);
//         },
//         controller: controller,
//         focusNode: focusNode,
//         decoration: new InputDecoration(
//           prefixIcon: prefixIcon,
//           suffixIcon: suffixIcon,
//           labelText: label,
//           filled: true,
//           fillColor: Colors.white,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10.0),
//             ),
//             borderSide: BorderSide(
//               color: Colors.grey.shade400,
//               width: 2,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10.0),
//             ),
//             borderSide: BorderSide(
//               color: Colors.blue.shade300,
//               width: 2,
//             ),
//           ),
//           contentPadding: EdgeInsets.all(15),
//           hintText: hint,
//         ),
//       ),
//     );
//   }
//
//   // Method for retrieving the current location
//   _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         _currentPosition = position;
//         print('CURRENT POS: $_currentPosition');
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 18.0,
//             ),
//           ),
//         );
//       });
//       await _getAddress();
//     }).catchError((e) {
//       print(e);
//     });
//   }
//
//   // Method for retrieving the address
//   _getAddress() async {
//     try {
//       List<Placemark> p = await placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);
//
//       Placemark place = p[0];
//
//       setState(() {
//         _currentAddress =
//             "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
//         startAddressController.text = _currentAddress;
//         _startAddress = _currentAddress;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   // Method for calculating the distance between two places
//   Future<bool> _calculateDistance() async {
//     try {
//       // Retrieving placemarks from addresses
//       List<Location> startPlacemark = await locationFromAddress(_startAddress);
//       List<Location> destinationPlacemark =
//           await locationFromAddress(_destinationAddress);
//
//       // Use the retrieved coordinates of the current position,
//       // instead of the address if the start position is user's
//       // current position, as it results in better accuracy.
//       double startLatitude = _startAddress == _currentAddress
//           ? _currentPosition.latitude
//           : startPlacemark[0].latitude;
//
//       double startLongitude = _startAddress == _currentAddress
//           ? _currentPosition.longitude
//           : startPlacemark[0].longitude;
//
//       double destinationLatitude = destinationPlacemark[0].latitude;
//       double destinationLongitude = destinationPlacemark[0].longitude;
//
//       String startCoordinatesString = '($startLatitude, $startLongitude)';
//       String destinationCoordinatesString =
//           '($destinationLatitude, $destinationLongitude)';
//
//       // Start Location Marker
//       Marker startMarker = Marker(
//         markerId: MarkerId(startCoordinatesString),
//         position: LatLng(startLatitude, startLongitude),
//         infoWindow: InfoWindow(
//           title: 'Start $startCoordinatesString',
//           snippet: _startAddress,
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       );
//
//       // Destination Location Marker
//       Marker destinationMarker = Marker(
//         markerId: MarkerId(destinationCoordinatesString),
//         position: LatLng(destinationLatitude, destinationLongitude),
//         infoWindow: InfoWindow(
//           title: 'Destination $destinationCoordinatesString',
//           snippet: _destinationAddress,
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       );
//
//       // Adding the markers to the list
//       markers.add(startMarker);
//       markers.add(destinationMarker);
//
//       print(
//         'START COORDINATES: ($startLatitude, $startLongitude)',
//       );
//       print(
//         'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
//       );
//
//       // Calculating to check that the position relative
//       // to the frame, and pan & zoom the camera accordingly.
//       double miny = (startLatitude <= destinationLatitude)
//           ? startLatitude
//           : destinationLatitude;
//       double minx = (startLongitude <= destinationLongitude)
//           ? startLongitude
//           : destinationLongitude;
//       double maxy = (startLatitude <= destinationLatitude)
//           ? destinationLatitude
//           : startLatitude;
//       double maxx = (startLongitude <= destinationLongitude)
//           ? destinationLongitude
//           : startLongitude;
//
//       double southWestLatitude = miny;
//       double southWestLongitude = minx;
//
//       double northEastLatitude = maxy;
//       double northEastLongitude = maxx;
//
//       // Accommodate the two locations within the
//       // camera view of the map
//       mapController.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           LatLngBounds(
//             northeast: LatLng(northEastLatitude, northEastLongitude),
//             southwest: LatLng(southWestLatitude, southWestLongitude),
//           ),
//           100.0,
//         ),
//       );
//
//       // Calculating the distance between the start and the end positions
//       // with a straight path, without considering any route
//       // double distanceInMeters = await Geolocator.bearingBetween(
//       //   startLatitude,
//       //   startLongitude,
//       //   destinationLatitude,
//       //   destinationLongitude,
//       // );
//
//       await _createPolylines(startLatitude, startLongitude, destinationLatitude,
//           destinationLongitude);
//
//       double totalDistance = 0.0;
//
//       // Calculating the total distance by adding the distance
//       // between small segments
//       for (int i = 0; i < polylineCoordinates.length - 1; i++) {
//         totalDistance += _coordinateDistance(
//           polylineCoordinates[i].latitude,
//           polylineCoordinates[i].longitude,
//           polylineCoordinates[i + 1].latitude,
//           polylineCoordinates[i + 1].longitude,
//         );
//       }
//
//       setState(() {
//         _placeDistance = totalDistance.toStringAsFixed(2);
//         print('DISTANCE: $_placeDistance km');
//       });
//
//       return true;
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }
//
//   // Formula for calculating distance between two coordinates
//   // https://stackoverflow.com/a/54138876/11910277
//   double _coordinateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }
//
//   // Create the polylines for showing the route between two places
//   _createPolylines(
//     double startLatitude,
//     double startLongitude,
//     double destinationLatitude,
//     double destinationLongitude,
//   ) async {
//     polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "Secrets.API_KEY", // Google Maps API Key
//       PointLatLng(startLatitude, startLongitude),
//       PointLatLng(destinationLatitude, destinationLongitude),
//       travelMode: TravelMode.transit,
//     );
//
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.red,
//       points: polylineCoordinates,
//       width: 3,
//     );
//     polylines[id] = polyline;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//      Provider.of<Future<List<Place>>>(context,listen: false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height * 0.67;
//     var width = MediaQuery.of(context).size.width;
//     return Column(
//       children: [
//         Container(
//           height: height,
//           width: width,
//           child: Scaffold(
//             key: _scaffoldKey,
//             body: Stack(
//               children: <Widget>[
//                 // Map View
//                 GoogleMap(
//                   markers: Set<Marker>.from(markers),
//                   initialCameraPosition: _initialLocation,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                   mapType: MapType.normal,
//                   zoomGesturesEnabled: true,
//                   zoomControlsEnabled: false,
//                   polylines: Set<Polyline>.of(polylines.values),
//                   onMapCreated: (GoogleMapController controller) {
//                     mapController = controller;
//                   },
//                 ),
//                 // Show zoom buttons
//                 SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         ClipOval(
//                           child: Material(
//                             color: Colors
//                                 .blue.shade100, // button color
//                             child: InkWell(
//                               splashColor:
//                               Colors.blue, // inkwell color
//                               child: SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 child: Icon(Icons.add),
//                               ),
//                               onTap: () {
//                                 mapController.animateCamera(
//                                   CameraUpdate.zoomIn(),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         ClipOval(
//                           child: Material(
//                             color: Colors
//                                 .blue.shade100, // button color
//                             child: InkWell(
//                               splashColor:
//                               Colors.blue, // inkwell color
//                               child: SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 child: Icon(Icons.remove),
//                               ),
//                               onTap: () {
//                                 mapController.animateCamera(
//                                   CameraUpdate.zoomOut(),
//                                 );
//                               },
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Show the place input fields & button for
//                 // showing the route
//                 // SafeArea(
//                 //   child: Align(
//                 //     alignment: Alignment.topCenter,
//                 //     child: Padding(
//                 //       padding: const EdgeInsets.only(top: 10.0),
//                 //       child: Container(
//                 //         decoration: BoxDecoration(
//                 //           color: Colors.white70,
//                 //           borderRadius: BorderRadius.all(
//                 //             Radius.circular(20.0),
//                 //           ),
//                 //         ),
//                 //         width: width * 0.9,
//                 //         child: Padding(
//                 //           padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//                 //           child: Column(
//                 //             mainAxisSize: MainAxisSize.min,
//                 //             children: <Widget>[
//                 //               Text(
//                 //                 'Places',
//                 //                 style: TextStyle(fontSize: 20.0),
//                 //               ),
//                 //               SizedBox(height: 10),
//                 //               _textField(
//                 //                   label: 'Start',
//                 //                   hint: 'Choose starting point',
//                 //                   prefixIcon: Icon(Icons.looks_one),
//                 //                   suffixIcon: IconButton(
//                 //                     icon: Icon(Icons.my_location),
//                 //                     onPressed: () {
//                 //                       startAddressController.text = _currentAddress;
//                 //                       _startAddress = _currentAddress;
//                 //                     },
//                 //                   ),
//                 //                   controller: startAddressController,
//                 //                   focusNode: startAddressFocusNode,
//                 //                   width: width,
//                 //                   locationCallback: (String value) {
//                 //                     setState(() {
//                 //                       _startAddress = value;
//                 //                     });
//                 //                   }),
//                 //               SizedBox(height: 10),
//                 //               _textField(
//                 //                   label: 'Destination',
//                 //                   hint: 'Choose destination',
//                 //                   prefixIcon: Icon(Icons.looks_two),
//                 //                   controller: destinationAddressController,
//                 //                   focusNode: desrinationAddressFocusNode,
//                 //                   width: width,
//                 //                   locationCallback: (String value) {
//                 //                     setState(() {
//                 //                       _destinationAddress = value;
//                 //                     });
//                 //                   }),
//                 //               SizedBox(height: 10),
//                 //               Visibility(
//                 //                 visible: _placeDistance == null ? false : true,
//                 //                 child: Text(
//                 //                   'DISTANCE: $_placeDistance km',
//                 //                   style: TextStyle(
//                 //                     fontSize: 16,
//                 //                     fontWeight: FontWeight.bold,
//                 //                   ),
//                 //                 ),
//                 //               ),
//                 //               SizedBox(height: 5),
//                 //               ElevatedButton(
//                 //                 onPressed: (_startAddress != '' &&
//                 //                     _destinationAddress != '')
//                 //                     ? () async {
//                 //                   startAddressFocusNode.unfocus();
//                 //                   desrinationAddressFocusNode.unfocus();
//                 //                   setState(() {
//                 //                     if (markers.isNotEmpty) markers.clear();
//                 //                     if (polylines.isNotEmpty)
//                 //                       polylines.clear();
//                 //                     if (polylineCoordinates.isNotEmpty)
//                 //                       polylineCoordinates.clear();
//                 //                     _placeDistance = null;
//                 //                   });
//                 //
//                 //                   _calculateDistance().then((isCalculated) {
//                 //                     if (isCalculated) {
//                 //                       ScaffoldMessenger.of(context)
//                 //                           .showSnackBar(
//                 //                         SnackBar(
//                 //                           content: Text(
//                 //                               'Distance Calculated Sucessfully'),
//                 //                         ),
//                 //                       );
//                 //                     } else {
//                 //                       ScaffoldMessenger.of(context)
//                 //                           .showSnackBar(
//                 //                         SnackBar(
//                 //                           content: Text(
//                 //                               'Error Calculating Distance'),
//                 //                         ),
//                 //                       );
//                 //                     }
//                 //                   });
//                 //                 }
//                 //                     : null,
//                 //                 child: Padding(
//                 //                   padding: const EdgeInsets.all(8.0),
//                 //                   child: Text(
//                 //                     'Show Route'.toUpperCase(),
//                 //                     style: TextStyle(
//                 //                       color: Colors.white,
//                 //                       fontSize: 20.0,
//                 //                     ),
//                 //                   ),
//                 //                 ),
//                 //                 style: ElevatedButton.styleFrom(
//                 //                   primary: Colors.red,
//                 //                   shape: RoundedRectangleBorder(
//                 //                     borderRadius: BorderRadius.circular(20.0),
//                 //                   ),
//                 //                 ),
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 // Show current location button
//                 SafeArea(
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           right: 10.0, bottom: 10.0),
//                       child: ClipOval(
//                         child: Material(
//                           color: Colors
//                               .orange.shade100, // button color
//                           child: InkWell(
//                             splashColor:
//                             Colors.orange, // inkwell color
//                             child: SizedBox(
//                               width: 56,
//                               height: 56,
//                               child: Icon(Icons.my_location),
//                             ),
//                             onTap: () {
//                               mapController.animateCamera(
//                                 CameraUpdate.newCameraPosition(
//                                   CameraPosition(
//                                     target: LatLng(
//                                       _currentPosition.latitude,
//                                       _currentPosition.longitude,
//                                     ),
//                                     zoom: 18.0,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Text("Nearby Hospitals"),
//         Expanded(
//     child: FutureProvider<List<Place>>(
//       create: (context)=>Provider.of<Future<List<Place>>>(context),
//       initialData: [],
//       child: Container(
//         color: Colors.red,
//       ),
//     ),
//         )
//         // Expanded(
//         //     child: Padding(
//         //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         //   child: ListView.separated(
//         //       padding: const EdgeInsets.only(top: 10),
//         //       itemBuilder: (_, index) {
//         //         return FutureProvider(
//         //           create: (context) => GeoLocator().getDist(
//         //               _currentPosition.latitude,
//         //               _currentPosition.longitude,
//         //               snapshot
//         //                   .data![index].geometry!.location!.lat,
//         //               snapshot
//         //                   .data![index].geometry!.location!.lng),
//         //           initialData: [],
//         //           child: Card(
//         //             child: ListTile(
//         //               leading: SvgPicture.asset(
//         //                   'assets/images/hospital.svg'),
//         //               title: Text(
//         //                 snapshot.data![index].name.toString(),
//         //                 style: const TextStyle(
//         //                   color: greenClr,
//         //                   fontFamily: 'Candara',
//         //                 ),
//         //               ),
//         //               subtitle: Consumer<double>(
//         //                 builder: (context,km,widget){
//         //                   var dislattude=snapshot.data![index].geometry!.location!.lat;
//         //                   var dislongtude=snapshot.data![index].geometry!.location!.lat;
//         //                   return km!=null?Row(
//         //                     children: [
//         //                       snapshot.data![index].vicinity!=null?
//         //                     Text("${snapshot.data![index].vicinity} \u00b7",style: TextStyle(
//         //                       color: blackClr,
//         //                       fontFamily:
//         //                       'Candara',
//         //                     ),):Text(""),
//         //                       Text("${(km/1000).toStringAsFixed(1)} km",style: TextStyle(
//         //                         color: blackClr,
//         //                         fontFamily:
//         //                         'Candara',
//         //                       ),
//         //                       )
//         //
//         //
//         //                     ],
//         //
//         //                   ):Text("");
//         //                 },
//         //               ),
//         //               trailing: IconButton(
//         //                 icon: const Icon(
//         //                   Icons.directions,
//         //                   color: greenClr,
//         //                 ),
//         //                 onPressed: () {},
//         //               ),
//         //             ),
//         //           ),
//         //         );
//         //       },
//         //       separatorBuilder: (_, index) => SizedBox(
//         //             height: 10,
//         //           ),
//         //       itemCount: snapshot.data!.length),
//         // ))
//       ],
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:medical_assistant/api/marker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:provider/provider.dart';
// // import '../api/geolocator.dart';
// // import '../api/places.dart';
// // import '../models/place.dart';
// // import '../theme.dart';
// //
// // class MapPatScreen extends StatefulWidget {
// //   const MapPatScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<MapPatScreen> createState() => _MapPatScreenState();
// // }
// //
// // class _MapPatScreenState extends State<MapPatScreen> {
// //   final geoServise = GeoLocator();
// //   final markerServise = Markersa();
// //   List<Marker> marke = [];
// //   Set<Polyline> _Polyline = {};
// //   List<LatLng> polylineCoordinates = [];
// //   PolylinePoints? polylinePoints;
// //   double short = 10;
// //   double shortlattude = 31.420637;
// //   double shortlongtude = 34.359642;
// //   @override
// //   void initState() {
// //     Provider.of<Position>(context,listen: false);
// //     Provider.of<Future<List<Place>>>(context,listen: false);
// //     polylinePoints = PolylinePoints();
// //     Permission.location.request();
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var currentPosition = Provider.of<Position>(context);
// //     var placesProvider = Provider.of<Future<List<Place>>?>(context);
// // //     // ImageConfiguration configuration = createLocalImageConfiguration(context);
// //     return FutureProvider(
// //       create: (_) => placesProvider,
// //       initialData: [],
// //       child: Scaffold(
// //           body: (currentPosition != null)
// //               ? FutureBuilder<List<Place>>(
// //             future: PlaceS().getPlaces(
// //               latt: currentPosition.latitude,
// //               lngt: currentPosition.longitude,
// //             ),
// //             builder: (context, snapshot) {
// //               var markers = (snapshot.data != null)
// //                   ? markerServise.getMarkers(snapshot.data)
// //                   : marke;
// //               print('the set${Set<Marker>.of(markers)}');
// //               if (snapshot.hasData) {
// //                 return Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   children: <Widget>[
// //                     SizedBox(
// //                       height: MediaQuery.of(context).size.height / 1.5,
// //                       width: MediaQuery.of(context).size.width,
// //                       child: GoogleMap(
// //                           myLocationEnabled: true,
// //                           myLocationButtonEnabled: true,
// //                           initialCameraPosition: const CameraPosition(
// //                               target: LatLng(
// //                                   31.426028984666445, 34.380744928859755),
// //                               zoom: 16.0),
// //                           zoomGesturesEnabled: true,
// //                           markers: Set<Marker>.of(markers),
// //                           polylines: _Polyline,
// //                           onMapCreated: (controller) {
// //                             setPolyline(
// //                                 startlatitude: currentPosition.latitude,
// //                                 startlongitude: currentPosition.longitude,
// //                                 endlatitude: shortlattude,
// //                                 endlongitude: shortlongtude);
// //                           }),
// //                     ),
// //                     Container(
// //                         height: 40,
// //                         padding: const EdgeInsetsDirectional.only(
// //                           start: 20,
// //                           top: 10,
// //                         ),
// //                         alignment: AlignmentDirectional.topStart,
// //                         child: const Text(
// //                           "Nearby Hospitals",
// //                           style: TextStyle(
// //                               fontSize: 20,
// //                               // height: 10,
// //                               fontFamily: 'Candara',
// //                               color: blueClr),
// //                         )),
// //                     Expanded(
// //                       child: Padding(
// //                         padding:
// //                         const EdgeInsets.symmetric(horizontal: 20),
// //                         child: ListView.separated(
// //                             padding: const EdgeInsets.only(top: 0),
// //                             itemCount: snapshot.data!.length,
// //                             separatorBuilder: (_, index) {
// //                               return const SizedBox(
// //                                 height: 10,
// //                               );
// //                             },
// //                             itemBuilder: (_, index) {
// //                               return FutureProvider(
// //                                 create: (context) => geoServise.getDist(
// //                                     currentPosition.latitude,
// //                                     currentPosition.longitude,
// //                                     snapshot.data![index].geometry!
// //                                         .location!.lat,
// //                                     snapshot.data![index].geometry!
// //                                         .location!.lng),
// //                                 initialData: [],
// //                                 child: Card(
// //                                   child: ListTile(
// //                                     leading: SvgPicture.asset(
// //                                         'assets/images/hospital.svg'),
// //                                     title: Text(
// //                                       snapshot.data![index].name
// //                                           .toString(),
// //                                       style: const TextStyle(
// //                                         color: greenClr,
// //                                         fontFamily: 'Candara',
// //                                       ),
// //                                     ),
// //                                     subtitle: Consumer<double?>(
// //                                       builder: (context, km, widget) {
// //                                         shortlattude = snapshot.data![0]
// //                                             .geometry!.location!.lat;
// //                                         shortlongtude = snapshot
// //                                             .data![0]
// //                                             .geometry!
// //                                             .location!
// //                                             .lng;
// //                                         return (km != null)
// //                                             ? Row(
// //                                           children: [
// //                                             ((snapshot
// //                                                 .data![
// //                                             index]
// //                                                 .vicinity !=
// //                                                 null)
// //                                                 ? Text(
// //                                               '${snapshot.data![index].vicinity} \u00b7 ',
// //                                               style:
// //                                               const TextStyle(
// //                                                 color:
// //                                                 blackClr,
// //                                                 fontFamily:
// //                                                 'Candara',
// //                                               ),
// //                                             )
// //                                                 : const Text(
// //                                                 'No clear address')),
// //                                             const Spacer(),
// //                                             Text(
// //                                               "${(km / 1000).toStringAsFixed(1)} km",
// //                                               style:
// //                                               const TextStyle(
// //                                                 color: greenClr,
// //                                                 fontFamily:
// //                                                 'Candara',
// //                                               ),
// //                                             )
// //                                           ],
// //                                         )
// //                                             : Container();
// //                                       },
// //                                     ),
// //                                     trailing: IconButton(
// //                                       icon: const Icon(
// //                                         Icons.directions,
// //                                         color: greenClr,
// //                                       ),
// //                                       onPressed: () {},
// //                                     ),
// //                                   ),
// //                                 ),
// //                               );
// //                             }),
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               } else {
// //                 return const CircularProgressIndicator();
// //               }
// //             },
// //           )
// //               : const Center(
// //             child: const CircularProgressIndicator(),
// //           )),
// //     );
// //   }
// //
// //   void setPolyline(
// //       {required double startlatitude,//خط طول نقطة البداية
// //         required double startlongitude,//خط عرض نقطة البداية
// //         required double endlatitude,//خط طول نقطة النهاية
// //         required double endlongitude//خط عرض نقطة النهاية
// //       }) async {
// //     PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
// //       'AIzaSyCpbK_5pts7uhrQJLxpu7N3-LzePoDOMqg',
// //       PointLatLng(startlatitude, startlongitude),
// //       PointLatLng(endlatitude, endlongitude),
// //     );
// //     if (result.status == 'OK') {
// //       result.points.forEach((point) {
// //         setState(() {
// //           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //
// //         });
// //       });
// //       setState(() {
// //         _Polyline.add(Polyline(
// //             polylineId: const PolylineId('polyline'),
// //             width: 5,
// //             color: Colors.blue,
// //             points: polylineCoordinates));
// //       });
// //     }
// //   }
// //
// //   static String deviceSuffix(BuildContext context) {
// //     String deviceSuffix = '';
// //     TargetPlatform platform = Theme.of(context).platform;
// //     switch (platform) {
// //       case TargetPlatform.android:
// //         deviceSuffix = '_android';
// //         break;
// //       case TargetPlatform.iOS:
// //         deviceSuffix = '_ios';
// //         break;
// //       default:
// //         deviceSuffix = '';
// //     }
// //     return deviceSuffix;
// //   }
// // }
