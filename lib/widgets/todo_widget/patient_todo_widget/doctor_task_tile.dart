import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_assistant/models/todo_model/doctor_todo_model.dart';


import '../../../models/todo_model/patient_todo_model.dart';
import '../../../size_config.dart';
import '../../../theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DoctorTaskTile extends StatelessWidget {
  const DoctorTaskTile(this.task, {Key? key}) : super(key: key);
  final DoctorTask task;

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
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _gEtColor(task.color)),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${task.title}',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:Colors.white),
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
                          '${task.startTime} - ${task.endTime}',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 13, color: Colors.grey[200]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${task.note}',
                      style: GoogleFonts.lato(
                        textStyle:
                        const TextStyle(fontSize: 15, color:white),
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
                task.isCompleted == 0 ? AppLocalizations.of(context)!.todo : AppLocalizations.of(context)!.completed,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: white),
                ),
              ),
            )
          ],
        ),
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
}
