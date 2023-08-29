import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../pages/login_page_t.dart';
import 'back_buttons.dart';

Future<bool> _onBackPressedFromAppBar(context) async {
  return await BackFunctions.onBackPressedFromAppBar(context);
}

Future<bool> _onBackPressedFromAppBarAdmin(context) async {
  bool shouldNavigate =
      await BackFunctions.onBackPressedFromAppBarAdmin(context);

  if (shouldNavigate) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPageT()),
    );
  }

  return shouldNavigate;
}

AppBar arrowBack(context, data1, data2, data3) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Padding(
        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 40,
        ),
      ),
      onPressed: () {
        FieldUtils.clearFields(
            controller1: data1, controller2: data2, controller3: data3);
        _onBackPressedFromAppBar(context);
      },
    ),
  );
}

AppBar arrowBackAdmin(context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Padding(
        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 40,
        ),
      ),
      onPressed: () {
        _onBackPressedFromAppBarAdmin(context);
      },
    ),
  );
}
