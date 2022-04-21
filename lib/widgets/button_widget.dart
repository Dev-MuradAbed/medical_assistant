import 'package:flutter/material.dart';


import '../theme.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ButtonWidget({Key? key,required this.text,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child:  Text(
        text,
        style: const TextStyle(
          fontFamily: 'Candara',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: greenClr,
        minimumSize: const Size(160, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}