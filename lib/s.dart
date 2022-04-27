import 'package:flutter/material.dart';
customErroerScreens(){
  return ErrorWidget.builder=((details){
return Material(
  child: Container(
    color: Colors.black87,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(''),
        const SizedBox(height: 20.0),
        const Padding(
            padding: EdgeInsets.all(8.0),
          child: Text(
            'Sorry something went wrong please try again later',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        )

      ],
    ),
  ),
);
  });
}