import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

Padding textFormFieldProcess(String labeltext, TextEditingController controller,
    List<TextInputFormatter>? inputFormatter) {
  return Padding(
    padding: EdgeInsets.only(right: 25.0.sp, left: 25.sp, top: 10.sp),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bu alanlar boş bırakılamaz";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle:
            Constants.getTextStyle(Theme.of(Get.context!).hintColor, 11.0.sp),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(Get.context!).hintColor),
          borderRadius: BorderRadius.circular(14.sp),
        ),
      ),
    ),
  );
}
