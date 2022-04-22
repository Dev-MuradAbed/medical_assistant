import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

const Color blueClr = Color(0xFF184093);
const Color greenClr = Color(0xFF19A049);
const Color whitClr = Color(0xFFFFFFFF);
const Color blackClr = Color(0xFF000000);
const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      backgroundColor: darkGreyClr,
      brightness: Brightness.dark,
  );

}

TextStyle get heading{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black
      )
  );
}
TextStyle get subheading{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.black
      )
  );
}
TextStyle get TitleStyle{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black
      )
  );
}
TextStyle get subTitle{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black
      )
  );
}
TextStyle get bodyText{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black
      )
  ); 
}
TextStyle get body2Text{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black
      )
  );
}

TextStyle get titleStyle{
  return  const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color:darkGreyClr
    // Get.isDarkMode? Colors.white:Colors.black

  );
}

