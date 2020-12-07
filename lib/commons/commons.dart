import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
class DateUtil{
  static DateFormat format = DateFormat("yyyy-MM-dd");
}
class TextUtil{
  static TextStyle textStyle = TextStyle(
      fontFamily: 'WorkSans-Italic-VariableFont_wght',
      fontWeight: FontWeight.bold,
      color: Colors.redAccent,
      fontSize: 25,
      letterSpacing: 4);
  static TextStyle textStyleSmall = TextStyle(
      fontFamily: 'WorkSans-Italic-VariableFont_wght',
      fontWeight: FontWeight.normal,
      fontSize: 15,
      letterSpacing: 2);

  static TextStyle textStyleHeading = TextStyle(
      fontFamily: 'WorkSans-Italic-VariableFont_wght',
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      fontSize: 25,
      letterSpacing: 4);
}
BoxDecoration decoration = new BoxDecoration(
  gradient: new LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blue, Colors.white],
  ),
);