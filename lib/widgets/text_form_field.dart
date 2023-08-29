import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

Padding textFormFieldProcess(String labeltext, TextEditingController controller,
    List<TextInputFormatter>? inputFormatter) {
  return Padding(
    padding: EdgeInsets.only(right: 25.0.sp, left: 25.sp, top: 10.sp),
    child: TextFormField(
      controller: controller,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: Constants.getTextStyle(Colors.grey, 11.0.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.sp),
        ),
      ),
    ),
  );
}
