import 'package:flutter/material.dart';
import 'package:sanofi_main/constants/constants.dart';

AlertDialog alertDialogProcess(
    Text? title, Icon? icon, Widget? content, List<Widget>? actions) {
  return AlertDialog(
    title: title,
    elevation: 0,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    icon: icon,
    content: content,
    iconPadding: const EdgeInsets.only(top: 10, bottom: 5),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: const EdgeInsets.all(5),
    actions: actions,
    titleTextStyle: Constants.getTextStyle(Colors.black, 16.0),
  );
}
