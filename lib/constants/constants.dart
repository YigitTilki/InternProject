import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      padding: EdgeInsets.only(top: 16.0.sp, bottom: 8.sp),
      child: SizedBox(
        height: 50.sp,
        width: 250.sp,
        child: Image.asset("assets/SNY_BIG.png"),
      ),
    );
  }
}

String sifre = "sifre";
