import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sanofi_main/pages/login_page_s.dart';
import 'package:sanofi_main/widgets/connection_popup.dart';
import 'package:sizer/sizer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();

    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // İnternet bağlantısı olmadığında hasInternet'i false olarak ayarla.
      setState(() {
        hasInternet = false;
      });
      // İnternet bağlantısı yoksa uyarı göster
      // ignore: use_build_context_synchronously
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
                style: Constants.getTextStyle(Colors.white, 12.sp),
              ),
              content: Text(
                'wifi-kontrol'.tr,
                style: Constants.getTextStyle(Colors.white, 11.sp),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'wifi-ayar'.tr,
                    style: Constants.getTextStyle(Colors.white, 8.sp),
                  ),
                  onPressed: () {
                    openWifiSettings();
                  },
                ),
                TextButton(
                  child: Text(
                    'devam-et'.tr,
                    style: Constants.getTextStyle(Colors.white, 8.sp),
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
                    style: Constants.getTextStyle(Colors.white, 8.sp),
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
    } else {
      // İnternet bağlantısı olduğunda hasInternet'i true olarak ayarla.
      setState(() {
        hasInternet = true;
      });
      // İnternet bağlantısı varsa 2 saniye sonra LoginPage'e git
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPageS()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 170.sp,
          width: 150.sp,
          child: Image.asset("assets/SNY.png"),
        ),
      ),
    );
  }
}
