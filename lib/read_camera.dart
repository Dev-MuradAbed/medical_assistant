import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_assistant/screen/auth/login_screen.dart';
import 'package:medical_assistant/widgets/count_down_timer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wakelock/wakelock.dart';

import 'controllers/result_controller/result_controller.dart';
import 'models/result_model/result_model.dart';
import 'models/sensorvalue.dart';
class PlusRate extends StatefulWidget {
  const PlusRate({Key? key}) : super(key: key);

  @override
  State<PlusRate> createState() => _PlusRateState();
}

class _PlusRateState extends State<PlusRate>with SingleTickerProviderStateMixin,WidgetsBindingObserver {
  final ResultController _resultController = ResultController();
  List<SalesData>datas=[
    SalesData('jan', 35),
    SalesData('feb', 25),
    SalesData('mar', 30),
    SalesData('apr', 15),
    SalesData('may', 20),
  ];
   bool _toggled=false;
  List<SensorValue> _data =<SensorValue>[];
  double _alpha=0.3;
  double _buttonScale=1;
 String buttonText="Check Heart Rate";
  int _bpm=0;
  int _fs=30;
 int _windowLen=30*6;
   late AnimationController _animationController;
    CameraController? _controller;
    CameraImage? _image;
    double? _avg;
  DateTime? _now;
  Timer? _timerImage,_timer;
  int seconds=60;
  List data=[];
  bool done=true;
  @override
  void initState() {
    super.initState();
    _animationController=
        AnimationController(vsync: this,duration:const  Duration(milliseconds: 500));
    _animationController.addListener(() {
      setState(() {
        _buttonScale =1.0+_animationController.value*0.4;
      });
    });
    WidgetsBinding.instance?.addObserver(this);
    _resultController.getDoctorTask();
  }
  @override
  void dispose() {
    _timerImage?.cancel();
    _timer?.cancel();
    _toggled=false;
    _disposeController();
    Wakelock.disable();
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
    WidgetsBinding.instance
        ?.removeObserver(this);
  }
  @override
  void didChangeAppLifeCycleState(AppLifecycleState state){
    if(state==AppLifecycleState.inactive||state==AppLifecycleState.detached)return;
    final inbackground =(state ==AppLifecycleState.paused);
    if(inbackground){
      _controller?.setFlashMode(FlashMode.off);
      setState(() {
        buttonText="Check Heart Rate";
        _bpm=0;
        _timer?.cancel();
        seconds=60;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Medical examination"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex:1,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                _controller!=null&&_toggled?AspectRatio(aspectRatio: _controller!.value.aspectRatio,child: CameraPreview(_controller!),):
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      alignment: Alignment.center,
                                      color: Colors.grey.shade300,
                                    )
                              ],

                            ),
                          ),
                        ),),
                    Expanded(flex:1,
                        child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CountDownTimer(
                            width: 150,
                            height: 150,
                            bgColor: Colors.green,
                            color: Colors.blue,
                            total: 60,
                            bpm: _bpm,

                          )

                        ],
                      ),
                    ))

                  ],
                )),
           const SizedBox(width: 40,height: 40,),
            Expanded(flex: 1,
              child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform.scale(
                        scale: _buttonScale,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          color: Colors.green,
                          onPressed: (){
                            if (_toggled) {
                              buttonText = "Check Heart Rate";
                              _untoggle();
                            } else {
                              buttonText = "Stop";
                              _toggle();
                            }
                          },
                        ),

                      ),
                      MaterialButton(
                          child: const Text(
                            "Records",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                          }),
                    ],
                  )
                ],
              ),

            ),),
               Row(
                children: [
                  const CircleAvatar(radius: 2,backgroundColor:Colors.blue,),
                  const Text("Pulse Rate"),
                    Text('${_resultController.resultList[0].bpm}'),

                ],

            ),
            const SizedBox(width: 20,height: 20,),
            Expanded(flex: 1, child: Container(
              margin: const EdgeInsets.all(12),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text:'Half Yearly Sales Analysis'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<SalesData,String>>[
                  LineSeries<SalesData,String>(
                      dataSource: datas,
                      xValueMapper: (SalesData sales,_)=>sales.day,
                      yValueMapper: (SalesData sales,_)=>sales.bmp,
                  name: 'Sales',
                    dataLabelSettings: const DataLabelSettings(isVisible: true)
                  )

                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _clearData(){
    _data.clear();
    int now=DateTime.now().microsecondsSinceEpoch;
    for(int i=0;i<_windowLen;i++){
      _data.insert(0,
          SensorValue(DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 128));
    }
  }
  void _toggle(){
    startTimer();
    _clearData();
    _initController().then((onValue) {
      Wakelock.enable();
      _animationController.repeat(reverse: true);
      setState(() {
        _toggled = true;
      });
      _initTimer();
      _updateBPM();
    });
  }
   void _updateBPM() async {
     List<SensorValue> _values;
     double _avg;
     int _n;
     double _m;
     double _threshold;
     double _bpm;
     int _counter;
     int _previous;
     while (_toggled) {
       _values = List.from(_data); // create a copy of the current data array
       _avg = 0;
       _n = _values.length;
       _m = 0;
       _values.forEach((SensorValue value) {
         _avg += value.value / _n;
         if (value.value > _m) _m = value.value;
       });
       _threshold = (_m + _avg) / 2;
       _bpm = 0;
       _counter = 0;
       _previous = 0;
       for (int i = 1; i < _n; i++) {
         if (_values[i - 1].value < _threshold &&
             _values[i].value > _threshold) {
           if (_previous != 0) {
             _counter++;
             _bpm += 60 *
                 1000 /
                 (_values[i].time.millisecondsSinceEpoch - _previous);
           }
           _previous = _values[i].time.millisecondsSinceEpoch;
         }
       }
       if (_counter > 0) {
         _bpm = _bpm / _counter;
         print(_bpm);
         setState(() {
           this._bpm = ((1 - _alpha) * this._bpm + _alpha * _bpm).toInt();
         });
       }
       await Future.delayed(Duration(
           milliseconds:
           1000 * _windowLen ~/ _fs));
     }
   }
   void _untoggle() {
     _disposeController();
     Wakelock.disable();
     _animationController.stop();
     _animationController.value = 0.0;
     setState(() {
       _toggled = false;
       _timer?.cancel();
       seconds = 60;
     });
   }
   void _disposeController() {
     _controller?.dispose();
     _controller = null;
   }
   Future<void> _initController() async {
     try {
       List _cameras = await availableCameras();
       _controller = CameraController(_cameras.first, ResolutionPreset.low);
       await _controller?.initialize();
       Future.delayed(const Duration(milliseconds: 50)).then((onValue) {
         _controller?.setFlashMode(FlashMode
             .torch);
       });
       _controller?.startImageStream((CameraImage image) {
         _image = image;
       });
     } catch (Exception) {
       print(Exception);
     }
   }
   void _initTimer() {
     _timerImage = Timer.periodic(Duration(milliseconds: 1000 ~/ _fs), (timer) {
       if (_toggled) {
         if (_image != null) _scanImage(_image!);
       } else {
         timer.cancel();
       }
     });
   }
   void _scanImage(CameraImage image) {
     _now = DateTime.now();
     _avg =
         image.planes.first.bytes.reduce((value, element) => value + element) /
             image.planes.first.bytes.length;
     if (_data.length >= _windowLen) {
       _data.removeAt(0);
     }
     setState(() {
       _data.add(SensorValue(_now!, 255 - _avg!));
     });
   }
   void startTimer() {
     const onesec =
     const Duration(seconds: 1); // here we are declaring the 1 second
     _timer = Timer.periodic(onesec, (Timer timer) {
       // periodic method of Timer class is used to call the method again and again at an interval of duration parameter.
       // till the timer is stopped by the cancel method
       if (seconds == 0) {
         setState(() {
           timer.cancel(); // when the seconds reached to 0 stop the timer
           seconds =
           60; // when the timer is stopped set the timer text to 60 again
           _untoggle(); // stop the BPM estimation process when the timer reached to 0
           buttonText =
           "Check Heart Rate"; // when the timer stops change the text to Check Heart Rate because BPM process is stopped
           _save(); // here save method is called to save the BPM value when timer is over
         });
       } else {
         setState(() {
           seconds -=
           1; // here we are decreasing the seconds by 1 each time till it reach to 0
         });
       }
     });
   }
   _save() async {
    try{
      int value = await _resultController.addTask(task: ResultModel(
       hourTime:DateTime.now().hour.toString() ,
        minuteTime: DateTime.now().minute.toString(),
        bpm: _bpm,
        date:DateTime.now().toString(),
      ));
      debugPrint("test $value");
      debugPrint("The Length ${_resultController.resultList[1].bpm}  $_bpm ${DateTime.now().hour.toString()}");
}catch(e){debugPrint("$e");
    }
     // List list = _dateTime().split(
     //     " ");
     // String date = list[0].toString();
     // String time = list[1].toString().substring(0,
     //     5);
     // final directory =
     // await getExternalStorageDirectory();
     // final file = File(
     //     '${directory!.path}/heartRate.txt');
     // final text = "\n" +
     //     date +
     //     " " +
     //     time +
     //     " " +
     //     _bpm.toString();
     // await file.writeAsString(text,
     //     mode: FileMode
     //         .append);
     // print('saved');
   }
   String _dateTime() {
     DateTime now =  DateTime.now();
     return now
         .toString();
   }
}
class SalesData{
  final String day;
  final double bmp;

  SalesData(this.day, this.bmp);

}