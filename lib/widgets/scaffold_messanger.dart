import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

SnackBar snackBar() {
  return SnackBar(
    elevation: 10,
    shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.purple, width: 2)),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/giphy-unscreen.gif",
          height: 20.sp,
          width: 20.sp,
        ),
        Text(
          'hatali-giris'.tr,
          style:
              Constants.getTextStyle(Theme.of(Get.context!).hintColor, 16.sp),
        ),
        Image.asset(
          "assets/giphy-unscreen.gif",
          height: 20.sp,
          width: 20.sp,
        ),
      ],
    ),
  );
}
