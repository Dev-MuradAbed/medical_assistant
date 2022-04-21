import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';


import 'package:intl/intl.dart';
import 'package:medical_assistant/models/todo_model/doctor_todo_model.dart';

import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


import '../screen/todo_screen/notification_screen.dart';


// import '/models/task01.dart';

class DoctorNotificationHelper {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject =
  BehaviorSubject<String>();
  BuildContext context;
  DoctorNotificationHelper(this.context);

  initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject(context);
    await _configureLocalTimeZone();
    // await requestIOSPermissions(flutterLocalNotificationsPlugin);
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('logo_png');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload!);
      },
    );
  }

  displayNotification({required String title, required String body}) async {
    print('doing test');
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  cancleNotification(DoctorTask task) async {
    flutterLocalNotificationsPlugin.cancel(task.id!);
  }

  cancleAllNotification() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  scheduledNotification(int hour, int minutes, DoctorTask task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _nextInstanceOfTenAM(
          hour, minutes, task.remind!, task.repeat!, task.date!),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM(
      int hour, int minutes, int remind, String repeat, String date) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    var formmatedDate = DateFormat.yMd().parse(date);
    final tz.TZDateTime fd = tz.TZDateTime.from(formmatedDate, tz.local);

    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);

    if (scheduledDate.isBefore(now)) {
      if (repeat == 'Daily') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formmatedDate.day) + 1, hour, minutes);
      }
      if (repeat == 'Weekly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formmatedDate.day) + 7, hour, minutes);
      }
      if (repeat == 'Monthly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year,
            (formmatedDate.month) + 1, formmatedDate.day, hour, minutes);
      }
//      scheduledDate = scheduledDate.add(const Duration(days: 1));

      scheduledDate = afterRemind(remind, scheduledDate);
    }

    return scheduledDate;
  }

  tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
    if (remind == 5) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 5));
    }

    if (remind == 10) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 10));
    }

    if (remind == 15) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 15));
    }

    if (remind == 20) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 20));
    }
    return scheduledDate;
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }


  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload,) async {

    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(body!),
      );
    });
    // Get.dialog(Text(body!));
  }

  void _configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('My payload is ' + payload);
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationScreen(payload: payload),
          ));

    });
  }
}
