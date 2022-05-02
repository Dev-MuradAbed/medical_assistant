import 'package:flutter/material.dart';
import 'package:medical_assistant/models/result_model.dart';
import 'package:medical_assistant/theme.dart';
class ListRate extends StatelessWidget {




  const ListRate(this.model,{Key? key} ) : super(key: key);
  final ResultModel model ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: greenClr),
        ),
        child: ListTile(
          leading: const Icon(Icons.timer_outlined,color: greenClr,),

          trailing:  Icon(model.heartRate==null?Icons.bloodtype_outlined:Icons.monitor_heart_outlined,color: greenClr,),
          title:  Padding(
            padding:   const EdgeInsets.only(bottom: 10),
            child:  Text('${model.dayDate} ,${model.monthDate} ,${model.yearTime} ${model.hourTime}:${model.munitTime}'),
          ),
          subtitle:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              model.heartRate==null?Text('${model.sy}/${model.dy} mmHg'):
              Text('${model.heartRate} bmp',),
              const Spacer(),
              const Text("Normal Rate"),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}