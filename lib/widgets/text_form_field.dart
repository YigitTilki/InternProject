import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

Padding textFormFieldProcess(String labeltext, TextEditingController controller,
    List<TextInputFormatter>? inputFormatter) {
  return Padding(
    padding: const EdgeInsets.only(right: 25.0, left: 25, top: 10),
    child: TextFormField(
      controller: controller,
      inputFormatters: inputFormatter,
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
