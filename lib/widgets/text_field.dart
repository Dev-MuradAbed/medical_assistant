import 'package:flutter/material.dart';


import '../theme.dart';

class TextInput extends StatefulWidget {
  TextInput({
    Key? key,
    this.widgetIcon ,
    this.sufWidget,
     this.hint,
     this.readOnly = false,
    required this.label,
     this.controller,
    this.obscureText = false,
     this.keyboardType=TextInputType.text,
    // this.onPressed,
    this.onTap, this.onSaved, this.validator,
  }) : super(key: key);
   // VoidCallback? onPressed;
   VoidCallback? onTap;
  final String label;
  final Widget? widgetIcon;
  final Widget? sufWidget;
  final TextEditingController? controller;
  final  bool obscureText;
  final TextInputType keyboardType;
  final bool readOnly;
 final  String? hint;
 final FormFieldSetter<String>? onSaved;
 final FormFieldValidator<String>? validator;
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

      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      onSaved: widget.onSaved,
      validator: widget.validator,
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
        hintText: widget.hint,

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
          borderSide:  const BorderSide(color: greenClr, width: 1.5),
          borderRadius: BorderRadius.circular(25),
        ),
         suffixIcon:widget.sufWidget,
         // IconButton(
         //   onPressed: widgets.onpressed,
         //  icon: widgets.sufWidget??Container(),
         // ),
      ),
      onTap: widget.onTap,
    );
  }
}
