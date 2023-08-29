import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../pages/login_page_t.dart';

class BackFunctions {
  static Future<bool> onBackPressed(context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white, // Popup arka plan rengi
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp), // Şekil ayarı
            ),
            title: Text(
              "Uygulamadan çıkmak istiyor musunuz?",
              style: Constants.getTextStyle(Colors.black, 17.0.sp),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.purple, // İstenilen renge ayarlayabilirsiniz
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  // Diğer stil ayarları
                ),
                child: Text(
                  "Hayır",
                  style: Constants.getTextStyle(Colors.white, 11.0.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0.sp),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  child: Text(
                    "Evet",
                    style: Constants.getTextStyle(Colors.white, 11.0.sp),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<bool> onBackPressedFromAppBar(context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            title: Text(
              "Bir önceki sayfaya dönmek istiyor musunuz?",
              style: Constants.getTextStyle(Colors.black, 17.0.sp),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                ),
                child: Text(
                  "Hayır",
                  style: Constants.getTextStyle(Colors.white, 11.0.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 10.sp,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  child: Text(
                    "Evet",
                    style: Constants.getTextStyle(Colors.white, 11.0.sp),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<bool> onBackPressedFromAppBarAdmin(context) async {
    bool shouldNavigate = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        title: Text(
          "Bir önceki sayfaya dönmek istiyor musunuz?",
          style: Constants.getTextStyle(Colors.black, 17.0.sp),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
            child: Text(
              "Hayır",
              style: Constants.getTextStyle(Colors.white, 11.0.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.sp),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
              child: Text(
                "Evet",
                style: Constants.getTextStyle(Colors.white, 11.0.sp),
              ),
            ),
          ),
        ],
      ),
    );

    if (shouldNavigate) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPageT()),
      );
    }

    return shouldNavigate;
  }
}
