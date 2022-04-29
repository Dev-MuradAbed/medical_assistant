import 'package:flutter/material.dart';

import '../theme.dart';


class Assistant {
  static ShowDilog(
      {required BuildContext context,
        required String Name,
      required String image,
        required String rate,
      }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image:  DecorationImage(
                          image: NetworkImage(
                           image,
                          ),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            color: greenClr, width: 2),
                        shape: BoxShape.circle,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    Name,
                    style: TextStyle(color: blueClr, fontSize: 20),
                  ),
                            const SizedBox(
                    height: 10,
                  ),
                            const Text(
                            'I wish you could stay away from any danger soon and rest somewhere far from the sun.',
                            textAlign: TextAlign.center,
                            style:  TextStyle(color: blueClr, fontSize: 20),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    rate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: blueClr, fontSize: 20),
                  ),

                ],
              ),
            ),

            actions: <Widget>[
              TextButton(
                child: const Text("ok", style: TextStyle(color: blueClr)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              TextButton(
                child: const Text("send", style: const TextStyle(color: blueClr)),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
  static ShowDilogNormal(
      {required BuildContext context,
        required String message}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
  static CheckStausBMP({required String Gendar, required int Age, required int Bmp,required String Name, required BuildContext context}) {
    String gendar = Gendar;
    int age = Age;
    int bmp = Bmp;
    if (gendar == 'mael') {
      if (age >= 18 && age <= 25) {
        if (bmp >= 49 && bmp <= 55) {
          ShowDilogNormal(
              context: context,
              message: 'You have a ATHLETE heart rate');
          print("ATHLETE");
        } else if (bmp >= 56 && bmp <= 61) {
          ShowDilogNormal(
              context: context,
              message: 'You have a EXCEL\'T heart rate');
          print('EXCEL\'T');
        } else if (bmp >= 62 && bmp <= 65) {
          ShowDilogNormal(
              context: context,
              message: 'You have a GOOD heart rate');
          print('GOOD');
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilogNormal(
              context: context,
              message: 'You have a ABOVE AV heart rate');
          print('ABOVE AV');
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilogNormal(
              context: context,
              message: 'You have a AVERAGE heart rate');
          print('AVERAGE');
        } else if (bmp >= 74 && bmp <= 81) {
          // ShowDilog(
          //   image:"" ,
          //     Name: "Murad KH Abed",
          //     rate: bmp.toString(),
          //     context: context),

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

  static CheckBooldPressure(
      {required int systolic,
      required int diastolic,
      required BuildContext context}) {
    int sy = systolic;
    int dy = diastolic;
    if (sy >= 40 && sy <= 105 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 40 && sy <= 105 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 40 && sy <= 105 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 40 && sy <= 105 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 40 && sy <= 105 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 106 && sy <= 120 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 106 && sy <= 120 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 106 && sy <= 120 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 106 && sy <= 120 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 106 && sy <= 120 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 121 && sy <= 140 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 121 && sy <= 140 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 121 && sy <= 140 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 121 && sy <= 140 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 121 && sy <= 140 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 141 && sy <= 160 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 141 && sy <= 160 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 141 && sy <= 160 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 141 && sy <= 160 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 141 && sy <= 160 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 161 && sy <= 180 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 161 && sy <= 180 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 161 && sy <= 180 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 161 && sy <= 180 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 161 && sy <= 180 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 181 && sy <= 200 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 181 && sy <= 200 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 181 && sy <= 200 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 181 && sy <= 200 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 181 && sy <= 200 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 201 && sy <= 220 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 201 && sy <= 220 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 201 && sy <= 220 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 201 && sy <= 220 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 201 && sy <= 220 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 221 && sy <= 240 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 221 && sy <= 240 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 221 && sy <= 240 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 221 && sy <= 240 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 221 && sy <= 240 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 241 && sy <= 260 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 241 && sy <= 260 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 241 && sy <= 260 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 241 && sy <= 260 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 241 && sy <= 260 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 261 && sy <= 280 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 261 && sy <= 280 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 261 && sy <= 280 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 261 && sy <= 280 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 261 && sy <= 280 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 281 && sy <= 300 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 281 && sy <= 300 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 281 && sy <= 300 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 281 && sy <= 300 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 281 && sy <= 300 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 301 && sy <= 320 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 301 && sy <= 320 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 301 && sy <= 320 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 301 && sy <= 320 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 301 && sy <= 320 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 321 && sy <= 340 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 321 && sy <= 340 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 321 && sy <= 340 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 321 && sy <= 340 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 321 && sy <= 340 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 341 && sy <= 360 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 341 && sy <= 360 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 341 && sy <= 360 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 341 && sy <= 360 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 341 && sy <= 360 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 361 && sy <= 380 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 361 && sy <= 380 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 361 && sy <= 380 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 361 && sy <= 380 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 361 && sy <= 380 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
    if (sy >= 381 && sy <= 400 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 381 && sy <= 400 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 381 && sy <= 400 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 381 && sy <= 400 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 381 && sy <= 400 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 401 && sy <= 420 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 401 && sy <= 420 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 401 && sy <= 420 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 401 && sy <= 420 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 401 && sy <= 420 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 421 && sy <= 440 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 421 && sy <= 440 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 421 && sy <= 440 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 421 && sy <= 440 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 421 && sy <= 440 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 441 && sy <= 460 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 441 && sy <= 460 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 441 && sy <= 460 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 441 && sy <= 460 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 441 && sy <= 460 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 461 && sy <= 480 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 461 && sy <= 480 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 461 && sy <= 480 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 461 && sy <= 480 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 461 && sy <= 480 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 481 && sy <= 500 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 481 && sy <= 500 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 481 && sy <= 500 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 481 && sy <= 500 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 481 && sy <= 500 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 501 && sy <= 520 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 501 && sy <= 520 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 501 && sy <= 520 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 501 && sy <= 520 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 501 && sy <= 520 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }

    if (sy >= 521 && sy <= 540 && dy >= 40 && dy <= 60) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a NORMAL blood pressure');
    } else if (sy >= 521 && sy <= 540 && dy >= 61 && dy <= 80) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a ABOVE AV blood pressure');
    } else if (sy >= 521 && sy <= 540 && dy >= 81 && dy <= 90) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a AVERAGE blood pressure');
    } else if (sy >= 521 && sy <= 540 && dy >= 91 && dy <= 100) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a BELOW AV blood pressure');
    } else if (sy >= 521 && sy <= 540 && dy >= 101 && dy <= 110) {
      ShowDilog(
          context: context,
          title: 'Congratulation',
          message: 'You have a POOR blood pressure');
    }
  }
}
