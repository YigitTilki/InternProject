import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/containers.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';

Padding areYouSureUser(
  String? containerText1,
  String? containerText2,
  String? containerText3,
  CollectionReference<Object?> collectionReference,
  BuildContext context,
  Future<void> Function()? deleteUser,
  ElevatedButton iAmSure,
) {
  return areYouSureContainer(
    [
      Text(
        containerText1!,
        style: Constants.getTextStyle(Colors.white, 14.0.sp),
      ),
      SizedBox(
        height: 10.sp,
      ),
      Text(
        containerText2!,
        style: Constants.getTextStyle(Colors.white, 14.0.sp),
      ),
      SizedBox(
        height: 10.sp,
      ),
      Text(
        containerText3!,
        style: Constants.getTextStyle(Colors.white, 14.0.sp),
      ),
      SizedBox(
        height: 20.sp,
      ),
      Text(
        'bilgileri-onayliyor-musunuz'.tr,
        textAlign: TextAlign.center,
        style: Constants.getTextStyle(Colors.white, 18.0.sp),
      ),
      SizedBox(
        height: 10.sp,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iAmSure,
          SizedBox(
            width: 15.sp,
          ),
          backElevatedButton(context, 'iptal'.tr),
        ],
      ),
    ],
  );
}
