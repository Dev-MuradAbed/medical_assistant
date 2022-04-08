import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_assistant/them.dart';

class MapPatScreen extends StatefulWidget {
  const MapPatScreen({Key? key}) : super(key: key);

  @override
  State<MapPatScreen> createState() => _MapPatScreenState();
}

class _MapPatScreenState extends State<MapPatScreen> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: const CameraPosition(
                      target:  LatLng(31.426028984666445, 34.380744928859755),
                      zoom: 16.0),
                  zoomGesturesEnabled: true,
                  onMapCreated: (controller) {
                  }),
            ),
Container(
    height: 40,
padding:const  EdgeInsetsDirectional.only(start: 20,top: 10,),
    alignment: AlignmentDirectional.topStart,
    child: const Text("Nearby Hospitals",style: TextStyle(
        fontSize: 20,
        // height: 10,
    fontFamily: 'Candara',
    color: blueClr
    ),)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 0),
                      itemCount: 30,
                      separatorBuilder: (_,index){
                        return const SizedBox(height: 10,);
                      },
                      itemBuilder: (_, index) {
                        return Card(
                          child: ListTile(
                            leading: SvgPicture.asset('assets/images/hospital.svg'),
                            title: const Text(
                                'Shifa Hospital',
                            style: TextStyle(
                              color: greenClr,
                              fontFamily: 'Candara',

                            ),),
                            subtitle: Row(
                              children: const [
                                 Text("Gaza,ss",style: TextStyle(
                                   color: blackClr,
                                   fontFamily: 'Candara',

                                 ),),
                                 Spacer(),
                                 Text("30km",style: TextStyle(
                                   color: greenClr,
                                   fontFamily: 'Candara',

                                 ),)
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.directions,
                                color:greenClr,
                              ),
                              onPressed: () {},
                            ),
                          ),

                        );
                      }),
                ),
              ),
            ),
          ],
        )
    );
  }



  }

