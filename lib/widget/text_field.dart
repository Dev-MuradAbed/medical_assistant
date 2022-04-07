import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../them.dart';

class TextInput extends StatefulWidget {


  TextInput({
    Key? key,
    this.widgetIcon ,
    this.sufWidget,
    required this.label,
    required this.controller,
    this.obscureText = false,
    required this.keyboardType,
    this.onpressed,
    this.onTap,
  }) : super(key: key);
   VoidCallback? onpressed;
   VoidCallback? onTap;
  final String label;
  final Widget? widgetIcon;
  final Widget? sufWidget;
  final TextEditingController controller;
 final  bool obscureText;
  final TextInputType keyboardType;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  String _selectGender = 'Meal';

  // List of items in our dropdown menu
  List genderList = [
    'Meal',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.widgetIcon,

        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Container(
          alignment: Alignment.center,
          width: 130,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: greenClr, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: blueClr,
              fontSize: 12,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: greenClr, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: greenClr, width: 1.5),
        ),
        focusColor: greenClr,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: greenClr, width: 1.5),
          borderRadius: BorderRadius.circular(25),
        ),
         suffixIcon:widget.sufWidget,
         // IconButton(
         //   onPressed: widget.onpressed,
         //  icon: widget.sufWidget??Container(),
         // ),
      ),
      onTap: widget.onTap,
    );
  }
}
