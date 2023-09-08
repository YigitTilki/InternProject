import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

Padding errorAlertDialog(String message) {
  return Padding(
    padding: const EdgeInsets.only(top: 50, bottom: 55, left: 50, right: 50),
    child: AlertDialog(
      elevation: 0,
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(
        children: [
          SizedBox(
              width: 40,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 15, right: 0, left: 0),
                child: Image.asset('assets/giphy-unscreen.gif'),
              )),
          Text(
            message,
            textAlign: TextAlign.center,
            style:
                Constants.getTextStyle(Theme.of(Get.context!).hintColor, 15.sp),
          ),
        ],
      ),
    ),
  );
}
