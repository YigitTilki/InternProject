import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

TextButton textButton(BuildContext context, route, String title) {
  return TextButton(
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => route,
        ),
      );
    },
    child: Text(
      title.tr,
      style: Constants.getTextStyle(Colors.black, 12.0.sp),
    ),
  );
}
