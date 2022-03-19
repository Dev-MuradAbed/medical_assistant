import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/widgets/ButtonClick.dart';
import 'package:medical_assistant/widgets/textFiledWidget.dart';
import 'package:medical_assistant/widgets/textTitleWidget.dart';

class SginUpScreen extends StatefulWidget {
  const SginUpScreen({Key? key}) : super(key: key);

  @override
  State<SginUpScreen> createState() => _SginUpScreenState();
}

class _SginUpScreenState extends State<SginUpScreen> {
  DateTime _dateTime =DateTime.now();
  String select='12/4/2000';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.purple.withOpacity(0.89),size: 30),
title: const TextTitleWidget(title: "Sgin Up"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: ListView(
          children:  [
            const SizedBox(
              height: 6,
            ),

            const TextFieldWidget(
              typeKey: TextInputType.number,
              topmargin: 0,
                hintTextField: 'Enter your Id',
                prefixIcon: Icons.perm_identity),
            /*رقم الهوية*/
            const TextFieldWidget(
                typeKey: TextInputType.text,
                hintTextField: "Enter User Name",
                prefixIcon: Icons.person_rounded),
            /*اسم المستخدم*/
            TextFieldWidget(
              ontap:(){
                showDatePicker(
                    context: context,
                    initialDate: _dateTime,
                    firstDate: DateTime(1990,1,1),
                    lastDate: DateTime(2022,12,31),builder: (context,child)=>Theme(data: ThemeData().copyWith(
                  colorScheme:  ColorScheme.dark(
                    primary: Colors.purple.shade500,
                    onPrimary: Colors.white,
                    surface: Color(0xaa00f),
                    onSurface: Colors.purple.shade800,
                  ),dialogBackgroundColor: Colors.grey.shade200.withOpacity(0.40)
                ), child: child!,)                ).then((value) {
                      setState(() {
                         select='${value!.month}/${value.day}/${value.year}';
                      });
                });
              } ,
                enable: false,
                hintTextField: select, prefixIcon: Icons.calendar_month),
            /*تاريخ الميلاد*/
            const TextFieldWidget(
                typeKey: TextInputType.number,
                hintTextField: 'User height',
                prefixIcon: Icons.straighten_outlined),
            /*طول المستحدم*/
            const TextFieldWidget(
                typeKey: TextInputType.number,
                hintTextField: "User weight",
                prefixIcon: Icons.monitor_weight_outlined),
            /*وزن المستحدم*/
             TextFieldWidget(hintTextField: "Gender", prefixIcon: Icons.man),
            /*جنس المستحدم*/
             TextFieldWidget(
                suffixIcon: Icons.visibility_off,
                suffixIconSize: 25,
                color: Colors.purple.withOpacity(0.89),
                typeKey: TextInputType.visiblePassword,
                obscureText: true,
                hintTextField: "Enter Password", prefixIcon: Icons.password),
            /*كلمة سر المستحدم*/
             TextFieldWidget(
                suffixIcon: Icons.visibility_off,
                suffixIconSize: 25,
                color: Colors.purple.withOpacity(0.89),
                typeKey: TextInputType.visiblePassword,
                obscureText: true,
                hintTextField: "Re_enter Password", prefixIcon: Icons.password),
            /*تاكيد كلمة السر المستحدم*/
            const SizedBox(
              height: 20,
            ),
            const ButtonClick(text: 'SGIN UP'),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
  a(){
    SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime:_dateTime ,
        onDateTimeChanged: (dateTime){
          print(dateTime);
          setState(() {
            _dateTime=dateTime;
          });
        },
      ),
    );
  }
}
