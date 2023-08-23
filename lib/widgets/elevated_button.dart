import 'package:flutter/material.dart';

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
