import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Assistant {
  static ShowDilogD({
    required BuildContext context,
    required String Name,
    required String image,
    required String rate,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: greenClr, width: 2),
                      shape: BoxShape.circle,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  Name,
                  style: const TextStyle(color: blueClr, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.i_wish_you_could,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: blueClr, fontSize: 20),
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
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok,
                    style: const TextStyle(color: blueClr)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.send,
                    style: const TextStyle(color: blueClr)),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  static ShowDilogNormal(
      {required BuildContext context, required String message}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
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
      required String name,
      required String image,
      required BuildContext context}) {
    String gendar = Gendar;
    int age = Age;
    int bmp = Bmp;

    if (gendar == 'mael') {
      if (age >= 18 && age <= 25) {
        if (bmp >= 49 && bmp <= 55) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 56 && bmp <= 61) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 62 && bmp <= 65) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 74 && bmp <= 81) {
          ShowDilogD(
            Name: name,
            image: image,
            rate: bmp.toString(),
            context: context,
          );
        } else if (bmp >= 82) {
          ShowDilogD(
              context: context, Name: name, image: image, rate: bmp.toString());
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 26 && age <= 35) {
        if (bmp >= 49 && bmp <= 54) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 55 && bmp <= 61) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 62 && bmp <= 65) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 66 && bmp <= 70) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 71 && bmp <= 74) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 75 && bmp <= 81) {
          ShowDilogD(
              context: context, image: image, Name: name, rate: bmp.toString());
        } else if (bmp >= 82) {
          ShowDilogD(
            rate: bmp.toString(),
            image: image,
            Name: name,
            context: context,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 36 && age <= 45) {
        if (bmp >= 50 && bmp <= 56) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 57 && bmp <= 62) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 63 && bmp <= 66) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 67 && bmp <= 70) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 71 && bmp <= 75) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 76 && bmp <= 82) {
          ShowDilogD(
            Name: name,
            image: image,
            rate: bmp.toString(),
            context: context,
          );
        } else if (bmp >= 83) {
          ShowDilogD(
            Name: name,
            image: image,
            rate: bmp.toString(),
            context: context,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 46 && age <= 55) {
        if (bmp >= 50 && bmp <= 57) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 58 && bmp <= 63) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 64 && bmp <= 67) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 68 && bmp <= 71) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 72 && bmp <= 76) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 77 && bmp <= 83) {
          ShowDilogD(
            Name: name,
            image: image,
            rate: bmp.toString(),
            context: context,
          );
        } else if (bmp >= 84) {
          ShowDilogD(
            Name: name,
            image: image,
            rate: bmp.toString(),
            context: context,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 56 && age <= 65) {
        if (bmp >= 51 && bmp <= 54) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 57 && bmp <= 61) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 62 && bmp <= 67) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 68 && bmp <= 71) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 72 && bmp <= 75) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 76 && bmp <= 81) {
          ShowDilogD(
            context: context,
            Name: name,
            image: image,
            rate: bmp.toString(),
          );
        } else if (bmp >= 82) {
          ShowDilogD(
            context: context,
            Name: name,
            image: image,
            rate: bmp.toString(),
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 65) {
        if (bmp >= 50 && bmp <= 55) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 56 && bmp <= 61) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 62 && bmp <= 65) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 74 && bmp <= 79) {
          ShowDilogD(
              context: context, Name: name, image: image, rate: bmp.toString());
        } else if (bmp >= 80) {
          ShowDilogD(
            Name: name,
            image: image,
            rate: bmp.toString(),
            context: context,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      }
    } else if (gendar == 'female') {
      if (age >= 18 && age <= 25) {
        if (bmp >= 54 && bmp <= 60) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 61 && bmp <= 65) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 74 && bmp <= 78) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 79 && bmp <= 84) {
          ShowDilogD(
              context: context, Name: name, image: image, rate: bmp.toString());
        } else if (bmp >= 85) {
          ShowDilogD(
            Name: name,
            image: image,
            rate: bmp.toString(),
            context: context,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (bmp >= 26 && bmp <= 35) {
        if (bmp >= 54 && bmp <= 59) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 60 && bmp <= 64) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 65 && bmp <= 68) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 69 && bmp <= 72) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 73 && bmp <= 76) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 77 && bmp <= 82) {
          ShowDilogD(
            rate: bmp.toString(),
            Name: name,
            image: image,
            context: context,
          );
        } else if (bmp >= 83) {
          ShowDilogD(
            rate: bmp.toString(),
            Name: name,
            image: image,
            context: context,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 36 && age <= 45) {
        if (bmp >= 54 && bmp <= 59) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 60 && bmp <= 64) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 65 && bmp <= 69) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 74 && bmp <= 78) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 79 && bmp <= 84) {
          ShowDilogD(
            rate: bmp.toString(),
            Name: name,
            image: image,
            context: context,
          );
        } else if (bmp >= 85) {
          ShowDilogD(
            context: context,
            rate: bmp.toString(),
            Name: name,
            image: image,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 46 && age <= 55) {
        if (bmp >= 54 && bmp <= 60) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 61 && bmp <= 65) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 66 && bmp <= 69) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 70 && bmp <= 73) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 74 && bmp <= 77) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 78 && bmp <= 83) {
          ShowDilogD(
            context: context,
            rate: bmp.toString(),
            Name: name,
            image: image,
          );
        } else if (bmp >= 84) {
          ShowDilogD(
            context: context,
            rate: bmp.toString(),
            Name: name,
            image: image,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 56 && age <= 65) {
        if (bmp >= 54 && bmp <= 59) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 60 && bmp <= 64) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 65 && bmp <= 68) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 69 && bmp <= 73) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 74 && bmp <= 77) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 78 && bmp <= 83) {
          ShowDilogD(
            context: context,
            rate: bmp.toString(),
            Name: name,
            image: image,
          );
        } else if (bmp >= 84) {
          ShowDilogD(
            context: context,
            rate: bmp.toString(),
            Name: name,
            image: image,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      } else if (age >= 65) {
        if (bmp >= 54 && bmp <= 59) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.you_have_a_athlete);
        } else if (bmp >= 60 && bmp <= 64) {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!
                  .you_have_a_excellent_heart_rate);
        } else if (bmp >= 65 && bmp <= 68) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_good_heart_rate);
        } else if (bmp >= 69 && bmp <= 72) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_above_heart_rate);
        } else if (bmp >= 73 && bmp <= 76) {
          ShowDilogNormal(
              context: context,
              message:
                  AppLocalizations.of(context)!.you_have_a_average_heart_rate);
        } else if (bmp >= 77 && bmp <= 84) {
          ShowDilogD(
            context: context,
            image: image,
            rate: bmp.toString(),
            Name: name,
          );
        } else if (bmp >= 85) {
          ShowDilogD(
            context: context,
            rate: bmp.toString(),
            Name: name,
            image: image,
          );
        } else {
          ShowDilogNormal(
              context: context,
              message: AppLocalizations.of(context)!.error_try_again);
        }
      }
    }
  }

  static CheckBooldPressure(
      {required int systolic,
      required int diastolic,
      required String name,
      required String image,
      required BuildContext context}) {
    int sy = systolic;
    int dy = diastolic;
    if (sy >= 40 && sy <= 105 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 40 && sy <= 105 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 40 && sy <= 105 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 40 && sy <= 105 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 40 && sy <= 105 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 106 && sy <= 120 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 106 && sy <= 120 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 106 && sy <= 120 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 106 && sy <= 120 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 106 && sy <= 120 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 121 && sy <= 140 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 121 && sy <= 140 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 121 && sy <= 140 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 121 && sy <= 140 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 121 && sy <= 140 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
      if (sy >= 141 && sy <= 160 && dy >= 40 && dy <= 60) {
        ShowDilogNormal(
            context: context,
            message:
                AppLocalizations.of(context)!.you_have_normal_blood_pressure);
      } else if (sy >= 141 && sy <= 160 && dy >= 61 && dy <= 80) {
        ShowDilogNormal(
            context: context,
            message:
                AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
      }
    } else if (sy >= 141 && sy <= 160 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 141 && sy <= 160 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 141 && sy <= 160 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 161 && sy <= 180 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 161 && sy <= 180 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 161 && sy <= 180 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 161 && sy <= 180 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 161 && sy <= 180 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 181 && sy <= 200 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 181 && sy <= 200 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 181 && sy <= 200 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 181 && sy <= 200 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 181 && sy <= 200 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 201 && sy <= 220 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 201 && sy <= 220 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 201 && sy <= 220 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 201 && sy <= 220 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 201 && sy <= 220 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 221 && sy <= 240 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 221 && sy <= 240 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 221 && sy <= 240 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 221 && sy <= 240 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 221 && sy <= 240 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 241 && sy <= 260 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 241 && sy <= 260 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 241 && sy <= 260 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 241 && sy <= 260 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 241 && sy <= 260 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 261 && sy <= 280 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 261 && sy <= 280 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 261 && sy <= 280 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 261 && sy <= 280 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 261 && sy <= 280 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 281 && sy <= 300 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 281 && sy <= 300 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 281 && sy <= 300 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 281 && sy <= 300 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 281 && sy <= 300 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 301 && sy <= 320 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 301 && sy <= 320 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 301 && sy <= 320 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 301 && sy <= 320 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 301 && sy <= 320 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 321 && sy <= 340 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 321 && sy <= 340 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 321 && sy <= 340 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 321 && sy <= 340 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 321 && sy <= 340 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 341 && sy <= 360 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 341 && sy <= 360 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 341 && sy <= 360 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 341 && sy <= 360 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 341 && sy <= 360 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 361 && sy <= 380 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 361 && sy <= 380 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 361 && sy <= 380 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 361 && sy <= 380 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 361 && sy <= 380 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 381 && sy <= 400 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 381 && sy <= 400 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 381 && sy <= 400 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 381 && sy <= 400 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 381 && sy <= 400 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 401 && sy <= 420 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 401 && sy <= 420 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 401 && sy <= 420 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 401 && sy <= 420 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 401 && sy <= 420 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 421 && sy <= 440 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 421 && sy <= 440 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 421 && sy <= 440 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 421 && sy <= 440 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 421 && sy <= 440 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 441 && sy <= 460 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 441 && sy <= 460 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 441 && sy <= 460 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 441 && sy <= 460 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 441 && sy <= 460 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 461 && sy <= 480 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 461 && sy <= 480 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 461 && sy <= 480 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 461 && sy <= 480 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 461 && sy <= 480 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
    if (sy >= 481 && sy <= 500 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 481 && sy <= 500 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 481 && sy <= 500 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 481 && sy <= 500 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 481 && sy <= 500 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 501 && sy <= 520 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 501 && sy <= 520 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 501 && sy <= 520 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 501 && sy <= 520 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 501 && sy <= 520 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }

    if (sy >= 521 && sy <= 540 && dy >= 40 && dy <= 60) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_normal_blood_pressure);
    } else if (sy >= 521 && sy <= 540 && dy >= 61 && dy <= 80) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_above_blood_pressure);
    } else if (sy >= 521 && sy <= 540 && dy >= 81 && dy <= 90) {
      ShowDilogNormal(
          context: context,
          message:
              AppLocalizations.of(context)!.you_have_a_average_blood_pressure);
    } else if (sy >= 521 && sy <= 540 && dy >= 91 && dy <= 100) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    } else if (sy >= 521 && sy <= 540 && dy >= 101 && dy <= 110) {
      ShowDilogD(
          context: context,
          rate: "$systolic / $diastolic mmhg",
          image: image,
          Name: name);
    }
  }
}
