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
}