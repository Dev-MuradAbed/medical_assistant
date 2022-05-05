import 'package:flutter/material.dart';

customErroerScreens() {
  return ErrorWidget.builder = ((details) {
    return Material(
        color: Color(0xFF38c172),
        child: Container(
            child: Image.asset(
          'assets/gif/waiting.gif',
          height: double.infinity,
          width: double.infinity,
        )));
  });
}
