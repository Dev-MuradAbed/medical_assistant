
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_assistant/provider/profile_provider.dart';
import 'package:medical_assistant/provider/result_provider.dart';
import 'package:medical_assistant/screen/list_result.dart';
import 'package:medical_assistant/theme.dart';
import 'package:medical_assistant/widgets/assistant.dart';

import 'package:medical_assistant/widgets/count_down_timer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wakelock/wakelock.dart';
import '../../models/result_model.dart';
import '../../models/sensorvalue.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlusRate extends StatefulWidget {
  const PlusRate({Key? key}) : super(key: key);

  @override
  HomeRateView createState() {
    return HomeRateView();
  }
}

class HomeRateView extends State<PlusRate>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool _toggled = false;
  final List<SensorValue> _data = <SensorValue>[];
  CameraController? _controller;
  final double _alpha = 0.3;
  late AnimationController _animationController;
  double _buttonScale = 1;
  String? buttonText;
  int _bpm = 0;
  final int _fs = 30;
  final int _windowLen = 30 * 6;
  var _image;
  double _avg=0.0;
  DateTime _now=DateTime.now();
  Timer?
  _timerImage, _timer;
  int seconds = 60;
  List data = [];
  bool done = true;

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).getTask();
    Provider.of<ResultProvider>(context, listen: false).getRecord();
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animationController.addListener(() {
      setState(() {
        _buttonScale = 1.0 + _animationController.value * 0.4;
      });
    });
    WidgetsBinding.instance?.addObserver(this);
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
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    final inbackground = (state == AppLifecycleState.paused);
    if (inbackground) {
      _controller?.setFlashMode(FlashMode.off);
      _untoggle();
      setState(() {
        buttonText = AppLocalizations.of(context)!.check_heart_rate;
        _bpm = 0;
        _timer?.cancel();
        seconds = 60;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      initialData: [],
      create: (context) =>Provider.of<ProfileProvider>(context, listen: false).getTask(),
      child: Consumer<ProfileProvider>(
        builder: (context, task, child){
          var profile =Provider.of<ProfileProvider>(context).listTask;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(18)),
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            children: [
                              if (_controller != null && _toggled) AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: CameraPreview(_controller!),
                              ) else Container(
                                height: 300,
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.center,
                                color: Colors.green.shade300,
                              ),
                            ],
                          ),
                        )),
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
                          bpm: _bpm,
                          textColor: Colors.black,
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
                            child: Text(
                              buttonText??AppLocalizations.of(context)!.check_heart_rate,
                              style:
                              const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            color: greenClr,
                            onPressed: () {
                              if (_toggled) {
                                buttonText = AppLocalizations.of(context)!.check_blood_pressure;
                                _untoggle();
                              } else {
                                DateFormat dateFormat = DateFormat("dd/MM/yyyy");
                                DateTime dateTime = dateFormat.parse(profile[0].birthday.toString());
                                buttonText = AppLocalizations.of(context)!.stop;
                                _toggle(
                                    age: DateTime.now().year-dateTime.year,
                                    name: profile[0].name.toString(),gender: profile[0].gender.toString(),image: profile[0].image.toString());
                              }
                            },
                          ),
                        ),
                        MaterialButton(
                            child:  Text(
                              AppLocalizations.of(context)!.record,
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            color: greenClr,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {
                              Provider.of<ResultProvider>(context, listen: false)
                                  .getRecord();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                  const ListResult()
                              ));
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children:  [
                          const CircleAvatar(
                            radius: 7,
                            backgroundColor: blueClr,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(AppLocalizations.of(context)!.heart_rate)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<ResultModel, String>>[
                    LineSeries<ResultModel, String>(
                        dataSource: Provider.of<ResultProvider>(context).resultList,
                        xValueMapper: (ResultModel sales, _) =>
                        Provider.of<ResultProvider>(context, listen: false)
                            .resultList
                            .length <
                            10
                            ? '${sales.hourTime}:${sales.munitTime}'
                            : sales.dayDate.toString(),
                        yValueMapper: (ResultModel sales, _) => sales.heartRate,
                        name: '',
                        color: greenClr,
                        dataLabelSettings: const DataLabelSettings(isVisible: true))
                  ],
                ),
              )
            ],
          );
        },
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
        _bpm = 0;
        _toggled = true;
      });
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
    _controller?.dispose();
    _controller = null;
  }

  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, ResolutionPreset.low);
      await _controller!.initialize();
      Future.delayed(const Duration(milliseconds: 50)).then((onValue) {
        _controller!.setFlashMode(FlashMode.torch);
      });
      _controller!.startImageStream((CameraImage image) {
        _image = image;
      });
    } catch (Exception) {

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
      _values = List.from(_data);
      for (var x in _values) {

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
     ;
        setState(() {
          this._bpm = ((1 - _alpha) * this._bpm + _alpha * _bpm).toInt();
        });
      }
      await Future.delayed(Duration(milliseconds: 1000 * _windowLen ~/ _fs));
    }
  }

  void startTimer({required String name, required String gender,required int age,required String image}) {
    const onesec = Duration(seconds: 1);
    _timer = Timer.periodic(onesec, (Timer timer) {
      if (seconds == 0) {
        setState(() {
          timer.cancel();
          seconds = 60;
          _untoggle();
          buttonText = AppLocalizations.of(context)!.check_heart_rate;
          _save(gender: gender,name: name,age: age,image: image);
        });
      } else {
        setState(() {
          seconds -= 1;
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
            heartRate: _bpm,
            date: DateTime.now().toString(),
            monthDate: DateTime.now().month,
            yearTime: DateTime.now().year,
            dayDate: DateTime.now().day,
            heartRateType: Assistant.checkStausBMP(Gendar: 'mael', Age: age, Bmp: _bpm, name: name, image: image, context: context),
          ));
      Provider.of<ResultProvider>(context, listen: false).getRecord();
      Assistant.checkStausBMP(Gendar: gender, Age: age, Bmp: _bpm,name: name,image:  image,context: context);

    } catch (e) {

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