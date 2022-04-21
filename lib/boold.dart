// import 'dart:async';
// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:medical_assistant/screen/auth/login_screen.dart';
// import 'package:medical_assistant/them.dart';
// import 'package:medical_assistant/widgets/count_down_timer_boold.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:wakelock/wakelock.dart';
// import 'controllers/result_controller/result_controller.dart';
// import 'models/result_model/result_model.dart';
// import 'models/sensorvalue.dart';
// import'dart:math'as math;
//
// class PlusRate extends StatefulWidget {
//   const PlusRate({Key? key}) : super(key: key);
//
//   @override
//   HomeRateView createState() {
//     return HomeRateView();
//   }
// }
//
// class HomeRateView extends State<PlusRate> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
//   bool _toggled = false;
//   final ResultController _resultController = ResultController();
//   List<SalesData>datas=[
//     SalesData('jan', 35),
//     SalesData('feb', 25),
//     SalesData('mar', 30),
//     SalesData('apr', 15),
//     SalesData('may', 20),
//   ];
//   final List<SensorValue> _data = <SensorValue>[];
//   CameraController? _controller;
//   double _alpha = 0.3;
//   late AnimationController _animationController;
//   double _buttonScale = 1;
//   String buttonText = "Check Blood Pressure";
//   int _sy = 0;
//   int _di = 0;
//   int _fs = 30;
//   int _windowLen = 30 * 6;
//   late CameraImage _image;
//   late double _avg;
//   late DateTime _now;
//   late Timer _timerImage,
//       _timer;
//   int seconds = 60;
//   List data = [];
//   bool done = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
//     _animationController
//         .addListener(() {
//       setState(() {
//         _buttonScale = 1.0 + _animationController.value * 0.4;
//       });
//     });
//     WidgetsBinding.instance!.addObserver(
//         this);
//   }
//
//   @override
//   void dispose() {
//     _timerImage.cancel();
//     _timer.cancel();
//     _toggled = false;
//     _disposeController();
//     Wakelock.disable();
//     _animationController.stop();
//     _animationController.dispose();
//     super.dispose();
//     WidgetsBinding.instance!
//         .removeObserver(this);
//   }
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.detached) return;
//     final inbackground = (state == AppLifecycleState.paused);
//     if (inbackground) {
//       _controller!
//           .setFlashMode(FlashMode.off);
//       _untoggle();
//       setState(() {
//         buttonText =
//         'Check Blood Pressure';
//         int _sy = 0;
//         int _di = 0;
//         _timer.cancel();
//         seconds =
//         60;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//         body: SafeArea(
//           top: true,
//           child: Column(
//             children: <Widget>[
//               Expanded(
//                   flex: 1,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Expanded(
//                         flex: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(18),
//                             ),
//                             child: Stack(
//                               fit: StackFit.expand,
//                               alignment: Alignment.center,
//                               children: <Widget>[
//                                 _controller != null && _toggled
//                                     ? AspectRatio(
//                                   aspectRatio:
//                                   _controller!.value.aspectRatio,
//                                   child: CameraPreview(_controller!),
//                                 )
//                                     : Container(
//                                   padding: const EdgeInsets.all(12),
//                                   alignment: Alignment.center,
//                                   color: Colors.green.shade300,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Center(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 CountDownTimer(
//                                   width: 150,
//                                   height: 150,
//                                   bgColor: Colors.blue.shade50,
//                                   color: greenClr,
//                                   current: seconds,
//                                   total: 60,
//                                   sp: _sy,
//                                   dp: _di,
//                                   textColor: Colors.black,
//                                 ),
//                               ],
//                             )),
//                       ),
//                     ],
//                   )),
//               const SizedBox(
//                 width: 40,
//                 height: 40,
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Center(
//                   child: Column(
//                     children: [
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Transform.scale(
//                               scale: _buttonScale,
//                               child: MaterialButton(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30)),
//                                 child: Text(
//                                   buttonText,
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                                 color: greenClr,
//                                 onPressed: () {
//                                   if (_toggled) {
//                                     buttonText = "Check Blood Pressure";
//                                     _untoggle();
//                                   } else {
//                                     buttonText = "Stop";
//                                     _toggle();
//                                   }
//                                 },
//                               ),
//                             ),
//                             MaterialButton(
//                                 child: const Text(
//                                   "Records",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                                 color: greenClr,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30)),
//                                 onPressed: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => const LoginScreen()));
//                                 }),
//                           ]),
//                       const SizedBox(
//                         width: 20,
//                         height: 20,
//                       ),
//                     ],
//                   ),
//
//                 ),
//               ),
//
//               Row(
//                 children: const[
//                   CircleAvatar(radius: 2,backgroundColor:Colors.blue,),
//                   Text("Blood Pressure")
//                 ],
//               ),
//               const SizedBox(width: 20,height: 20,),
//               Expanded(flex: 1, child: Container(
//                 margin: const EdgeInsets.all(12),
//                 child: SfCartesianChart(
//                   primaryXAxis: CategoryAxis(),
//                   title: ChartTitle(text:'Half Yearly Sales Analysis'),
//                   legend: Legend(isVisible: true),
//                   tooltipBehavior: TooltipBehavior(enable: true),
//                   series: <ChartSeries<SalesData,String>>[
//                     LineSeries<SalesData,String>(
//                         dataSource: datas,
//                         xValueMapper: (SalesData sales,_)=>sales.day,
//                         yValueMapper: (SalesData sales,_)=>sales.bmp,
//                         name: 'Sales',
//                         dataLabelSettings: const DataLabelSettings(isVisible: true)
//                     )
//                   ],
//                 ),
//               ),
//               )
//             ],
//           ),
//         )
//     );
//   }
//
//   void _clearData() {
//     _data.clear();
//     int now = DateTime.now().millisecondsSinceEpoch;
//     for (int i = 0; i < _windowLen; i++) {
//       _data.insert(
//           0,
//           SensorValue(
//               DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 128));
//     }
//   }
//
//   void _toggle() {
//     startTimer();
//     _clearData();
//     _initController().then((onValue) {
//       Wakelock.enable();
//       _animationController.repeat(reverse: true);
//       setState(() {
//         int _sy = 0;
//         int _di = 0;
//         _toggled = true;
//       });
//       // after is toggled
//       _initTimer();
//       _updateBPM();
//     });
//   }
//
//   void _untoggle() {
//     _disposeController();
//     Wakelock.disable();
//     _animationController.stop();
//     _animationController.value = 0.0;
//     setState(() {
//       _toggled = false;
//       _timer.cancel();
//       seconds = 60;
//     });
//   }
//
//   void _disposeController() {
//     _controller!.dispose();
//     _controller = null;
//   }
//
//   Future<void> _initController() async {
//     try {
//       List _cameras = await availableCameras();
//       _controller = CameraController(_cameras.first, ResolutionPreset.low);
//       await _controller!.initialize();
//       Future.delayed(const Duration(milliseconds: 50)).then((onValue) {
//         _controller!.setFlashMode(FlashMode
//             .torch);
//       });
//       _controller!.startImageStream((CameraImage image) {
//         _image = image;
//       });
//     } catch (Exception) {
//       print(Exception);
//     }
//   }
//
//   void _initTimer() {
//     _timerImage = Timer.periodic(Duration(milliseconds: 1000 ~/ _fs), (timer) {
//       if (_toggled) {
//         if (_image != null) _scanImage(_image);
//       } else {
//         timer.cancel();
//       }
//     });
//   }
//
//   void _scanImage(CameraImage image) {
//     _now = DateTime.now();
//     _avg =
//         image.planes.first.bytes.reduce((value, element) => value + element) /
//             image.planes.first.bytes.length;
//     if (_data.length >= _windowLen) {
//       _data.removeAt(0);
//     }
//     setState(() {
//       _data.add(SensorValue(_now, 255 - _avg));
//     });
//   }
//
//   void _updateBPM() async {
//     // Bear in mind that the method used to calculate the BPM is very rudimentar
//     // feel free to improve it :)
//
//     // Since this function doesn't need to be so "exact" regarding the time it executes,
//     // I only used the a Future.delay to repeat it from time to time.
//     // Ofc you can also use a Timer object to time the callback of this function
//     List<SensorValue> _values;
//     double _avg;
//     int _n;
//     double _m;
//     double _threshold;
//     double _bpm;
//     int _counter;
//     int _previous;
//     while (_toggled) {
//       _values = List.from(_data); // create a copy of the current data array
//       for (var x in _values) {
//         print(x);
//       }
//       _avg = 0;
//       _n = _values.length;
//       _m = 0;
//       _values.forEach((SensorValue value) {
//         _avg += value.value / _n;
//         if (value.value > _m) _m = value.value;
//       });
//       _threshold = (_m + _avg) / 2;
//       _bpm = 0;
//       _counter = 0;
//       _previous = 0;
//       for (int i = 1; i < _n; i++) {
//         if (_values[i - 1].value < _threshold &&
//             _values[i].value > _threshold) {
//           if (_previous != 0) {
//             _counter++;
//             _bpm += 60 *
//                 1000 /
//                 (_values[i].time.millisecondsSinceEpoch - _previous);
//           }
//           _previous = _values[i].time.millisecondsSinceEpoch;
//         }
//       }
//       if (_counter > 0) {
//         _bpm = _bpm / _counter;
//         print("_bpm ${_bpm}");
//         int Beats = _bpm.toInt();
//         setState(() {
//           int Hei = 185;
//           int Wei = 185;
//           int Agg = 22;
//           double Q = 4.5;
//           double ROB = 18.5;
//           double ET = (364.5 - 1.23 * Beats);
//           double BSA =
//               0.007184 * (math.pow(Wei, 0.425)) * (math.pow(Hei, 0.725));
//           double SV = (-6.6 +
//               (0.25 * (ET - 35)) -
//               (0.62 * Beats) +
//               (40.4 * BSA) -
//               (0.51 * Agg));
//           double PP =
//               SV / ((0.013 * Wei - 0.007 * Agg - 0.004 * Beats) + 1.307);
//           double MPP = Q * ROB;
//           _sy = (MPP + 3 / 2 * PP).toInt();
//           _di = (MPP - PP / 3).toInt();
//         });
//         print("the boold $_sy / $_di");
//       }
//       await Future.delayed(Duration(
//           milliseconds:
//           1000 * _windowLen ~/ _fs)); // wait for a new set of _data values
//     }
//   }
//
//   void startTimer() {
//     const onesec =
//     Duration(seconds: 1);
//     _timer = Timer.periodic(onesec, (Timer timer) {
//       if (seconds == 0) {
//         setState(() {
//           timer.cancel();
//           seconds =
//           60;
//           _untoggle();
//           buttonText =
//           "Check Blood Pressure";
//           _save();
//         });
//       } else {
//         setState(() {
//           seconds -=
//           1;
//         });
//       }
//     });
//   }
//
//   _save() async {
//     try{
//       // int value = await _resultController.addTask(task: ResultModel(
//       //   hourTime:DateTime.now().hour.toString() ,
//       //   minuteTime: DateTime.now().minute.toString(),
//       //   bpm: _bpm,
//       //   date:DateTime.now().toString(),
//       // ));
//       // debugPrint("test $value");
//       // debugPrint("The Length ${_resultController.resultList.length}  $_bpm}");
//     }catch(e){debugPrint("$e");
//     }
//     //   List list = _dateTime().split(
//     //       " ");
//     //   String date = list[0].toString();
//     //   String time = list[1].toString().substring(0,
//     //       5);
//     //   final directory =
//     //   await getExternalStorageDirectory();
//     //   final file = File(
//     //       '${directory!.path}/heartRate.txt');
//     //   final text = "\n" +
//     //       date +
//     //       " " +
//     //       time +
//     //       " " +
//     //       _bpm.toString();
//     //   await file.writeAsString(text,
//     //       mode: FileMode
//     //           .append);
//     //   print('saved');
//     // }
//     //
//     // String _dateTime() {
//     //   DateTime now =  DateTime
//     //       .now();
//     //   return now
//     //       .toString();
//   }
//
//   @override
//   Future<void> debugFillProperties(
//       DiagnosticPropertiesBuilder properties) async {
//     super.debugFillProperties(properties);
//     properties.add(DiagnosticsProperty<DateTime>('_now', _now));
//     properties.add(DiagnosticsProperty<DateTime>('_now', _now));
//   }
// }
// class SalesData{
//   final String day;
//   final double bmp;
//
//   SalesData(this.day, this.bmp);
//
// }