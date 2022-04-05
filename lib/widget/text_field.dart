import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../them.dart';

class TextInput extends StatefulWidget {
   TextInput({
    Key? key,
    this.oreIcon ,
    this.onChanged,
    this.sufIcon,
    required this.label,
    required this.controller,
    this.obscureText = false,
    required this.keyboardType,
  }) : super(key: key);
  final String label;
  final IconData? oreIcon;
  final IconData? sufIcon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
    VoidCallback? onChanged;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.oreIcon,
          color: greenClr.withOpacity(0.7),
          size: 24,
        ),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Container(
          alignment: Alignment.center,
          width: 79,
          height: 23,
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
         suffixIcon: IconButton(
             onPressed: widget.onChanged,
           icon: Icon(
             widget.sufIcon,
             color: const Color(0xff19A049).withOpacity(0.7),
             size: 20,
           ),

         ),
      ),
    );
  }
}
