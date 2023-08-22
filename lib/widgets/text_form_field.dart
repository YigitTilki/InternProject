import 'package:flutter/material.dart';

import '../constants/constants.dart';

Padding textFormFieldProcess(
    String labeltext, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(right: 25.0, left: 25, top: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: Constants.getTextStyle(Colors.grey, 14.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}
