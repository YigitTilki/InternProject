import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

ElevatedButton elevatedButtonProcess(Widget widget, Function() onpressed) {
  return ElevatedButton(
    onPressed: onpressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.sp),
      ),
      minimumSize: Size(70.sp, 25.sp),
    ),
    child: widget,
  );
}

ElevatedButton backElevatedButton(context, String text) {
  return elevatedButtonProcess(
    Text(
      text,
      style: Constants.getTextStyle(Colors.white, 11.0.sp),
    ),
    () => Navigator.pop(context),
  );
}
