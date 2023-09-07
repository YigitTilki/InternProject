import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

void showDeveloperNamesDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            'dev'.tr,
            style:
                Constants.getTextStyle(Theme.of(Get.context!).hintColor, 20.sp),
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Yiğit Tilki',
                style: Constants.getTextStyle(
                    Theme.of(Get.context!).hintColor, 15.sp),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'İbrahim Çerkezoğlu',
                  style: Constants.getTextStyle(
                      Theme.of(Get.context!).hintColor, 15.sp),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/smile.gif",
                  height: 40.sp,
                  width: 40.sp,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
