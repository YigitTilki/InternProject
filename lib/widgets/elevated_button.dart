import 'package:flutter/material.dart';

import '../constants/constants.dart';

ElevatedButton elevatedButtonProcess(Widget widget, Function() onpressed) {
  return ElevatedButton(
    onPressed: onpressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      minimumSize: const Size(100, 35),
    ),
    child: widget,
  );
}

ElevatedButton backElevatedButton(context, String text) {
  return elevatedButtonProcess(
    Text(
      text,
      style: Constants.getTextStyle(Colors.white, 13.0),
    ),
    () => Navigator.pop(context),
  );
}
