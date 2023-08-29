import 'package:flutter/material.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sizer/sizer.dart';

AlertDialog alertDialogProcess(
    Text? title, Icon? icon, Widget? content, List<Widget>? actions) {
  return AlertDialog(
    title: title,
    elevation: 0,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    icon: icon,
    content: content,
    iconPadding: EdgeInsets.only(top: 10.sp, bottom: 5.sp),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: EdgeInsets.all(5.sp),
    actions: actions,
    titleTextStyle: Constants.getTextStyle(Colors.black, 16.0.sp),
  );
}
