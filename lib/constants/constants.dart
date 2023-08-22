import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static TextStyle getTextStyle(color, size) {
    return TextStyle(
      color: color,
      fontFamily: "JosefinSans",
      fontSize: size,
    );
  }
}
