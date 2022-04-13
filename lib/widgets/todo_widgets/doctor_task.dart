
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/task_todo.dart';
import '../../todo_them/size_config.dart';
import '../../todo_them/theme.dart';


class DoctorTask extends StatefulWidget {
  const DoctorTask( {Key? key}) : super(key: key);

  @override
  State<DoctorTask> createState() => _DoctorTaskState();
}

class _DoctorTaskState extends State<DoctorTask> {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
   String? date;
  String? startTime;
  String? endTime;
  int? color;
   int? remind;
  String? repeat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenWidth(12)),
      child: FutureBuilder(
          future: _fetch(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: _gEtColor(color)),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title??'',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: Colors.grey[200],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$startTime - $endTime',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey[200]),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              note.toString()??'',
                              style: GoogleFonts.lato(
                                textStyle:
                                const TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 0.5,
                      height: 60,
                      color: Colors.grey[200]!.withOpacity(0.7),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        isCompleted == 0 ? 'TODO' : 'Completed',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }
        //   child: Container(
        //   padding: const EdgeInsets.all(8),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(16),
        //       color: _gEtColor(widget.task.color)),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: SingleChildScrollView(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 '${widget.task.title}',
        //                 style: GoogleFonts.lato(
        //                   textStyle: const TextStyle(
        //                       fontSize: 16,
        //                       fontWeight: FontWeight.bold,
        //                       color: Colors.white),
        //                 ),
        //               ),
        //               const SizedBox(height: 12),
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   Icon(
        //                     Icons.access_time,
        //                     size: 18,
        //                     color: Colors.grey[200],
        //                   ),
        //                   const SizedBox(width: 10),
        //                   Text(
        //                     '${widget.task.startTime} - ${widget.task.endTime}',
        //                     style: GoogleFonts.lato(
        //                       textStyle: TextStyle(
        //                           fontSize: 13, color: Colors.grey[200]),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               const SizedBox(height: 12),
        //               Text(
        //                 '${widget.task.note}',
        //                 style: GoogleFonts.lato(
        //                   textStyle:
        //                   const TextStyle(fontSize: 15, color: Colors.white),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //       Container(
        //         margin: const EdgeInsets.symmetric(horizontal: 10),
        //         width: 0.5,
        //         height: 60,
        //         color: Colors.grey[200]!.withOpacity(0.7),
        //       ),
        //       RotatedBox(
        //         quarterTurns: 3,
        //         child: Text(
        //           widget.task.isCompleted == 0 ? 'TODO' : 'Completed',
        //           style: GoogleFonts.lato(
        //             textStyle: const TextStyle(
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.white),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }

  _gEtColor(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
  _fetch()async{
    final firebaseUser =  FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      await FirebaseFirestore.instance.collection('NotesDoctor').
      doc(firebaseUser.uid).get().then((ds){
        title=ds.data()!['title'];
        note=ds.data()!['note'];
        isCompleted=ds.data()!['isCompleted'];
        date=ds.data()!['date'];
        startTime=ds.data()!['startTime'];
        endTime=ds.data()!['endTime'];
        color=ds.data()!['color'];
        remind=ds.data()!['remind'];
        repeat=ds.data()!['repeat'];
        print(title);
      }).catchError((e){
        print(e);
      });
    }
  }
}
