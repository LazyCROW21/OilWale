import 'package:flutter/material.dart';

const fontFamily = {'': ''};

class AppColorSwatche {
  static final Color primary = Colors.deepOrange;
  static final Color primaryAccent = Colors.deepOrangeAccent;
  static final Color black = Colors.black;
  static final Color grey = Colors.grey.shade700;
  static final Color white = Colors.white;
}

TextStyle textStyle(String tag, Color? color) {
  Color colorToUse = color ?? Colors.black;
  switch (tag) {
    case 'h1':
      return TextStyle(
          fontSize: 48.0, fontWeight: FontWeight.bold, color: colorToUse);
    case 'h2':
      return TextStyle(
          fontSize: 36.0, fontWeight: FontWeight.bold, color: colorToUse);
    case 'h3':
      return TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, color: colorToUse);
    case 'h4':
      return TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: colorToUse);
    case 'h5':
      return TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: colorToUse);
    case 'p1':
      return TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.normal, color: colorToUse);
    case 'p2':
      return TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: colorToUse);
    case 'p3':
      return TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.normal, color: colorToUse);
    default:
      return TextStyle();
  }
}

// shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18.0),
//                       ))