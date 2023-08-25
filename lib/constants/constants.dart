import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static TextStyle getTextStyle(color, size) {
    return TextStyle(
        color: color,
        fontFamily: "JosefinSans",
        fontSize: size,
        decoration: TextDecoration.none);
  }

  static Padding sanofiBig() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: SizedBox(
        height: 61,
        width: 278,
        child: Image.asset("assets/SNY_BIG.png"),
      ),
    );
  }
}

String sifre = "sifre";
