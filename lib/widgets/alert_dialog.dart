import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../pages/home_page.dart';
import 'connection_popup.dart';

AlertDialog alertDialogProcess(
    Text? title, Icon? icon, Widget? content, List<Widget>? actions) {
  return AlertDialog(
    title: title,
    elevation: 0,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    icon: icon,
    content: content,
    iconPadding: EdgeInsets.only(top: 10.sp, bottom: 5.sp),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: EdgeInsets.all(5.sp),
    actions: actions,
    titleTextStyle:
        Constants.getTextStyle(Theme.of(Get.context!).hintColor, 16.0.sp),
  );
}

AlertDialog noNetAlert(BuildContext context) {
  return AlertDialog(
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.wifi_off_sharp,
          color: Theme.of(Get.context!).hintColor,
        ),
        SizedBox(
          height: 15.sp,
        ),
        Text(
          'wifi-yok'.tr,
          textAlign: TextAlign.center,
          style:
              Constants.getTextStyle(Theme.of(Get.context!).hintColor, 12.sp),
        ),
      ],
    ),
    content: Text(
      'wifi-kontrol'.tr,
      textAlign: TextAlign.center,
      style: Constants.getTextStyle(Theme.of(Get.context!).hintColor, 11.sp),
    ),
    actionsAlignment: MainAxisAlignment.center,
    actions: <Widget>[
      TextButton(
        child: Text(
          'wifi-ayar'.tr,
          style: Constants.getTextStyle(Theme.of(Get.context!).hintColor, 8.sp),
        ),
        onPressed: () {
          openWifiSettings();
        },
      ),
      TextButton(
        child: Text(
          'devam-et'.tr,
          style: Constants.getTextStyle(Theme.of(Get.context!).hintColor, 8.sp),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
      ),
      TextButton(
        child: Text(
          'uygulama-kapat'.tr,
          style: Constants.getTextStyle(Theme.of(Get.context!).hintColor, 8.sp),
        ),
        onPressed: () {
          SystemNavigator.pop();
        },
      ),
    ],
  );
}
