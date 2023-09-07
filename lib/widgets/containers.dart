import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

Container adminPageContainerDesign(String image, String text) {
  return Container(
    width: 120.sp,
    height: 90.sp,
    decoration: ShapeDecoration(
      color: Theme.of(Get.context!).dividerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(3.0.sp),
          child: Image.asset(
            image,
            height: 50.sp,
            width: 50.sp,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(4.0.sp),
          child: Text(
            text,
            style: Constants.getTextStyle(Colors.white, 12.0.sp),
          ),
        ),
      ],
    ),
  );
}

Padding areYouSureContainer(List<Widget> children) {
  return Padding(
    padding: EdgeInsets.all(8.0.sp),
    child: Center(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.black.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
        ),
        height: 200.sp,
        width: double.infinity.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    ),
  );
}
