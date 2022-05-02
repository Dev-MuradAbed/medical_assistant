import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_assistant/models/result_model.dart';
import 'package:medical_assistant/provider/profile_provider.dart';
import 'package:medical_assistant/provider/result_provider.dart';

import 'package:medical_assistant/screen/list_result.dart';
import 'package:medical_assistant/screen/scann_home.dart';
import 'package:medical_assistant/theme.dart';
import 'package:medical_assistant/widgets/assistant.dart';
import 'package:medical_assistant/widgets/count_down_timer_boold.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wakelock/wakelock.dart';
import 'models/sensorvalue.dart';
import'dart:math'as math;

class BloodRate extends StatefulWidget {
  const BloodRate({Key? key}) : super(key: key);

  @override
  HomeRateView createState() {
    return HomeRateView();
  }
}

class HomeRateView extends State<BloodRate> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool _toggled = false;
  final List<SensorValue> _data = <SensorValue>[];
  CameraController? _controller;
  late AnimationController _animationController;
  double _buttonScale = 1;
  String buttonText = "Check Blood Pressure";
  int _sy = 0;
  int _di = 0;
  int _fs = 30;
  int _windowLen = 30 * 6;
   var _image;
  late double _avg;
  late DateTime _now;
   Timer? _timerImage,
      _timer;
  int seconds = 60;
  List data = [];
  bool done = true;

  @override
  void initState() {
//CameraImage late
    super.initState();
   ;
    _tooltipBehavior=TooltipBehavior(enable: true);
    Provider.of<ResultProvider>(context, listen: false).getRecord();
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animationController
        .addListener(() {
      setState(() {
        _buttonScale = 1.0 + _animationController.value * 0.4;
      });
    });
    WidgetsBinding.instance!.addObserver(
        this);
  }

  @override
  void dispose() {
    _timerImage?.cancel();
    _timer?.cancel();
    _toggled = false;
    _disposeController();
    Wakelock.disable();
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
    WidgetsBinding.instance!
        .removeObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    final inbackground = (state == AppLifecycleState.paused);
    if (inbackground) {
      _controller!
          .setFlashMode(FlashMode.off);
      _untoggle();
      setState(() {
        buttonText =
        'Check Blood Pressure';
         _sy = 0;
         _di = 0;
        _timer?.cancel();
        seconds =
        60;
      });
    }
  }
  late TooltipBehavior  _tooltipBehavior;
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      initialData: [],
      create: (context) =>Provider.of<ProfileProvider>(context, listen: false).getTask(),
      child: Consumer<ProfileProvider>(
          builder: (context, task, child){
            var profile =Provider.of<ProfileProvider>(context).listTask;
            return Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(18)),
                          child:SizedBox(
                            height: 130,
                            width: 130,
                            child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                _controller!=null&&_toggled?AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: CameraPreview(_controller!),

                                ):Container(
                                  height: 300,
                                  padding: const EdgeInsets.all(12),
                                  alignment: Alignment.center,
                                  color: Colors.green.shade300,
                                ),
                              ],

                            ),
                          )
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CountDownTimer(
                            width: 135,
                            height: 150,
                            bgColor: Colors.blue.shade50,
                            color: greenClr,
                            current: seconds,
                            total: 60,
                            sp: _sy,
                            dp: _di,
                            textColor: blueClr,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 30,
                  height: 30,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Transform.scale(
                            scale: _buttonScale,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(buttonText,  style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              ),
                              color: greenClr,
                              onPressed: () {
                                if (_toggled) {
                                  buttonText = "Check Blood Pressure";
                                  _untoggle();
                                } else {
                                  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
                                  DateTime dateTime = dateFormat.parse(profile[0].birthday.toString());
                                  buttonText = "Stop";
                                  _toggle(
                                      age: DateTime.now().year-dateTime.year,
                                      name: profile[0].name.toString(),gender: profile[0].gender.toString(),
                                  image: profile[0].image.toString()
                                  );
                                }
                              },

                            ),
                          ),
                          MaterialButton(
                              child: const Text(
                                "Records",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              color: greenClr,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {
                                Provider.of<ResultProvider>(context,
                                    listen: false)
                                    .getRecord();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                    const ListResult()));
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        child: Row(
                          children: const[
                            CircleAvatar(radius: 7,backgroundColor:blueClr,),
                            SizedBox(width: 10,),
                            Text("Blood Pressure")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: SfCartesianChart(
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    series: <ChartSeries>[
                      StackedLineSeries<ResultModel,String>(
                          dataSource: Provider.of<ResultProvider>(context).resultList,
                          xValueMapper: (ResultModel exp,_)=>Provider.of<ResultProvider>(context, listen: false)
                              .resultList
                              .length <
                              10
                              ? '${exp.hourTime}:${exp.munitTime}'
                              : exp.dayDate.toString(),
                          yValueMapper: (ResultModel exp,_)=>exp.dy,
                        name: "Sy",
                        markerSettings: const MarkerSettings(isVisible: true),

                      ),
                      StackedLineSeries<ResultModel,String>(
                          dataSource: Provider.of<ResultProvider>(context).resultList,
                          xValueMapper: (ResultModel exp,_)=>Provider.of<ResultProvider>(context, listen: false)
                              .resultList
                              .length <
                              10
                              ? '${exp.hourTime}:${exp.munitTime}'
                              : exp.dayDate.toString(),
                          yValueMapper: (ResultModel exp,_)=>exp.sy,
                      name: "Dy",
                        markerSettings: const MarkerSettings(isVisible: true),
                      ),
                    ],
                    primaryXAxis: CategoryAxis(),


                  ),
                )
              ],
            );

          }

      ),
    );
  }

  void _clearData() {
    _data.clear();
    int now = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < _windowLen; i++) {
      _data.insert(
          0,
          SensorValue(
              DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 128));
    }
  }

  void _toggle({required String name, required String gender,required int age,required String image}) {
    startTimer(gender: gender,name: name,age: age,image: image);
    _clearData();
    _initController().then((onValue) {
      Wakelock.enable();
      _animationController.repeat(reverse: true);
      setState(() {
         _sy = 0;
         _di = 0;
        _toggled = true;
      });
      // after is toggled
      _initTimer();
      _updateBPM();
    });
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
    _controller!.dispose();
    _controller = null;
  }

  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, ResolutionPreset.low);
      await _controller!.initialize();
      Future.delayed(const Duration(milliseconds: 50)).then((onValue) {
        _controller!.setFlashMode(FlashMode
            .torch);
      });
      _controller!.startImageStream((CameraImage image) {
        _image  = image;
      });
    } catch (Exception) {
      print(Exception);
    }
  }

  void _initTimer() {
    _timerImage = Timer.periodic(Duration(milliseconds: 1000 ~/ _fs), (timer) {
      if (_toggled) {
        if (_image != null) _scanImage(_image);
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
      _data.add(SensorValue(_now, 255 - _avg));
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
      for (var x in _values) {
        print(x);
      }
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
        print("_bpm ${_bpm}");
        int Beats = _bpm.toInt();
        setState(() {
          int Hei = 185;
          int Wei = 185;
          int Agg = 22;
          double Q = 4.5;
          double ROB = 18.5;
          double ET = (364.5 - 1.23 * Beats);
          double BSA =
              0.007184 * (math.pow(Wei, 0.425)) * (math.pow(Hei, 0.725));
          double SV = (-6.6 +
              (0.25 * (ET - 35)) -
              (0.62 * Beats) +
              (40.4 * BSA) -
              (0.51 * Agg));
          double PP =
              SV / ((0.013 * Wei - 0.007 * Agg - 0.004 * Beats) + 1.307);
          double MPP = Q * ROB;
          this._sy = (MPP + 3 / 2 * PP).toInt();
          this._di = (MPP - PP / 3).toInt();
        });
        print("the boold $_sy / $_di");
      }
      await Future.delayed(Duration(
          milliseconds:
          1000 * _windowLen ~/ _fs)); // wait for a new set of _data values
    }
  }

  void startTimer({required String name, required String gender,required int age,required String image}) {
    const onesec =
    Duration(seconds: 1);
    _timer = Timer.periodic(onesec, (Timer timer) {
      if (seconds == 0) {
        setState(() {
          timer.cancel();
          seconds =
          60;
          _untoggle();
          buttonText =
          "Check Blood Pressure";
          _save(gender: gender,name: name,age: age,image:image );
        });
      } else {
        setState(() {
          seconds -=
          1;
        });
      }
    });
  }

  _save({required String name, required String gender,required int age,required String image}) async {
    try {
      int value =
      await Provider.of<ResultProvider>(context, listen: false).addRecord(
          task: ResultModel(
            hourTime: DateTime.now().hour,
            munitTime: DateTime.now().minute,
            sy: _sy,
            dy: _di,
            date: DateTime.now().toString(),
            monthDate: DateTime.now().month,
            yearTime: DateTime.now().year,
            dayDate: DateTime.now().day,
          ));
      Provider.of<ResultProvider>(context, listen: false).getRecord();
      debugPrint("test $value");

      Assistant.CheckBooldPressure(systolic: _sy, diastolic: _di,image:image ,name: name, context: context,);
      debugPrint(
          "The Length ${Provider.of<ResultProvider>(context, listen: false).resultList.length} $_sy / $_di,");
    } catch (e) {
      debugPrint("$e");
    }

  }

  @override
  Future<void> debugFillProperties(
      DiagnosticPropertiesBuilder properties) async {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('_now', _now));
    properties.add(DiagnosticsProperty<DateTime>('_now', _now));
  }
}