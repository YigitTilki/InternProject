import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sanofi_main/pages/home_page.dart';
import 'package:sizer/sizer.dart';

Future<void> showNoInternetDialog(context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          // Geri tuşuna basıldığında hiçbir şey yapma
          return false;
        },
        child: AlertDialog(
          backgroundColor: const Color.fromARGB(255, 172, 69, 190),
          title: Text(
            'wifi-yok'.tr,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
          content: Text(
            'wifi-kontrol'.tr,
            style: TextStyle(color: Colors.white, fontSize: 11.sp),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'wifi-ayar'.tr,
                style: TextStyle(color: Colors.white, fontSize: 8.sp),
              ),
              onPressed: () {
                openWifiSettings();
              },
            ),
            TextButton(
              child: Text(
                'devam-et'.tr,
                style: TextStyle(color: Colors.white, fontSize: 8.sp),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const HomePage()), // AnaSayfa, ana sayfanızın sınıfını temsil eder
                );
              },
            ),
            TextButton(
              child: Text(
                'uygulama-kapat'.tr,
                style: TextStyle(color: Colors.white, fontSize: 8.sp),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

void openWifiSettings() async {
  const platform = MethodChannel('your_channel_name');

  try {
    await platform.invokeMethod('openWifiSettings');
  } on PlatformException catch (e) {
    // ignore: avoid_print
    print('Hata: $e');
  }
}
