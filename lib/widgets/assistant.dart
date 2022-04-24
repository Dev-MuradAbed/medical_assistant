import 'package:flutter/material.dart';

import '../utils/helpers.dart';

class Assistant with Helper {
  static ShowDilog(
      {required BuildContext context,
      required String title,
      required String message}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  static CheckStausBMP(
      {required String Gendar,
      required int Age,
      required int Bmp,
      required BuildContext context}) {
    String gendar = Gendar;
    int age = Age;
    int bmp = Bmp;
    if (gendar == 'mael') {
      if (age >= 18 && age <= 25) {
        if (bmp >= 49 && bmp <= 55) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 56 && bmp <= 61) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');
          print('EXCEL\'T');
        } else if (bmp >= 62 && bmp <= 65) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 74 && bmp <= 81) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
        } else if (bmp >= 82) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 26 && age <= 35) {
        if (bmp >= 49 && bmp <= 54) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          ;
          print("ATHLETE");
        } else if (bmp >= 55 && bmp <= 61) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 62 && bmp <= 65) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 66 && bmp <= 70) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 71 && bmp <= 74) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 75 && bmp <= 81) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 82) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 36 && age <= 45) {
        if (bmp >= 50 && bmp <= 56) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 57 && bmp <= 62) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 63 && bmp <= 66) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 67 && bmp <= 70) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 71 && bmp <= 75) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 76 && bmp <= 82) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 83) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 46 && age <= 55) {
        if (bmp >= 50 && bmp <= 57) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 58 && bmp <= 63) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 64 && bmp <= 67) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 68 && bmp <= 71) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 72 && bmp <= 76) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 77 && bmp <= 83) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 84) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 56 && age <= 65) {
        if (bmp >= 51 && bmp <= 54) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 57 && bmp <= 61) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 62 && bmp <= 67) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 68 && bmp <= 71) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 72 && bmp <= 75) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 76 && bmp <= 81) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 82) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 65) {
        if (bmp >= 50 && bmp <= 55) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 56 && bmp <= 61) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 62 && bmp <= 65) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 74 && bmp <= 79) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 80) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      }
    } else if (gendar == 'femael') {
      if (age >= 18 && age <= 25) {
        if (bmp >= 54 && bmp <= 60) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 61 && bmp <= 65) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 74 && bmp <= 78) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 79 && bmp <= 84) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 85) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (bmp >= 26 && bmp <= 35) {
        if (bmp >= 54 && bmp <= 59) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 60 && bmp <= 64) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 65 && bmp <= 68) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 69 && bmp <= 72) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 73 && bmp <= 76) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 77 && bmp <= 82) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 83) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 36 && age <= 45) {
        if (bmp >= 54 && bmp <= 59) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 60 && bmp <= 64) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 65 && bmp <= 69) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 74 && bmp <= 78) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 79 && bmp <= 84) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 85) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 46 && age <= 55) {
        if (bmp >= 54 && bmp <= 60) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 61 && bmp <= 65) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 74 && bmp <= 77) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 78 && bmp <= 83) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 84) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 56 && age <= 65) {
        if (bmp >= 54 && bmp <= 59) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 60 && bmp <= 64) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 65 && bmp <= 68) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 69 && bmp <= 73) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 74 && bmp <= 77) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 78 && bmp <= 83) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 84) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      } else if (age >= 65) {
        if (bmp >= 54 && bmp <= 59) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 60 && bmp <= 64) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a EXCEL\'T heart rate');

          print('EXCEL\'T');
        } else if (bmp >= 65 && bmp <= 68) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a GOOD heart rate');
          print('GOOD');
          print('GOOD');
        } else if (bmp >= 69 && bmp <= 72) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 73 && bmp <= 76) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 77 && bmp <= 84) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a BELOW AV heart rate');
          print('BELOW AV');
        } else if (bmp >= 85) {
          ShowDilog(
              context: context,
              title: 'Congratulation',
              message: 'You have a POOR heart rate');
          print('POOR');
        } else {
          ShowDilog(context: context, title: 'error', message: '');
          print('error');
        }
      }
    }
  }

  static CheckBooldPressure({required int systolic, required int diastolic, required BuildContext context}) {
    int sy = systolic;
    int dy = diastolic;
    if (sy >= 210 && dy >= 120) {
      ShowDilog(context: context, title: 'error', message: 'High Boold Pressure - satge 4 (Hypertension -stage 4)');
      print('High Boold Pressure - satge 4 (Hypertension -stage 4)');
    } else if (sy >= 180 && sy <= 210 && dy >= 110 && dy <= 120) {
      ShowDilog(context: context, title: 'error', message: 'High Boold Pressure - satge 3 (Hypertension -stage 3)');

      print('High Boold Pressure - satge 3 (Hypertension -stage 3)');
    } else if (sy >= 160 && sy <= 179 && dy >= 100 && dy <= 109) {
      ShowDilog(context: context, title: 'error', message: 'High Boold Pressure - satge 2 (Hypertension -stage 2)');

      print('High Boold Pressure - satge 2 (Hypertension -stage 2)');
    } else if (sy >= 140 && sy <= 159 && dy >= 90 && dy <= 99) {
      ShowDilog(context: context, title: 'error', message: 'High Boold Pressure - satge 1 (Hypertension -stage 1)');

      print('High Boold Pressure - satge 1 (Hypertension -stage 1)');
    } else if (sy >= 130 && sy <= 139 && dy >= 85 && dy <= 89) {
      ShowDilog(context: context, title: 'error', message: 'Per - Boold Pressure (Per -Hypertension)');

      print('Per - Boold Pressure (Per -Hypertension)');
    } else if (sy >= 121 && sy <= 129 && dy >= 81 && dy <= 84) {
      ShowDilog(context: context, title: 'error', message: 'High Normal Boold Pressure ');

      print('High Normal Boold Pressure ');
    } else if (sy >= 100 && sy <= 120 && dy >= 65 && dy <= 80) {
      ShowDilog(context: context, title: 'error', message: 'Normal Boold Pressure (Ideal Blood Pressure)');

      print('Normal Boold Pressure (Ideal Blood Pressure)');
    } else if (sy >= 90 && sy <= 99 && dy >= 60 && dy <= 64) {
      ShowDilog(context: context, title: 'error', message: 'Low Normal Boold Pressure');

      print('Low Normal Boold Pressure');
    } else if (sy >= 70 && sy <= 89 && dy >= 40 && dy <= 59) {
      ShowDilog(context: context, title: 'error', message: 'Low Normal Boold Pressure (Moderate Hypotension)');

      print('Low Normal Boold Pressure (Moderate Hypotension)');
    } else if (sy >= 50 && sy <= 69 && dy >= 35 && dy <= 39) {
      ShowDilog(context: context, title: 'error', message: 'Too Low Normal Boold Pressure (Severe Hypotension)');

      print('Too Low Normal Boold Pressure (Severe Hypotension)');
    } else if (sy <= 50 && dy <= 35) {
      ShowDilog(context: context, title: 'error', message: 'Extremely Low Normal Boold Pressure (Extremely Severe Hypotension)');

      print(
          'Extremely Low Normal Boold Pressure (Extremely Severe Hypotension)');
    } else {
      print('error');
    }
  }
}
