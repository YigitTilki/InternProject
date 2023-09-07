import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

Column userInfo(data1, data2) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.sp, right: 15.sp),
          child: Padding(
            padding: EdgeInsets.only(top: 25.sp),
            child: Text(
              data1?.text.toString() ?? "",
              style: Constants.getTextStyle(
                  Theme.of(Get.context!).hintColor, 24.0.sp),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 15.0.sp, right: 15.0.sp),
        child: Text(
          data2?.text.toString() ?? "",
          style: Constants.getTextStyle(
              Theme.of(Get.context!).colorScheme.primary, 24.0.sp),
        ),
      ),
    ],
  );
}
