// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../provider/theme_provider.dart';
import '../widgets/alert_dialog.dart';
import 'login_page_s.dart';

class HomePage extends StatefulWidget {
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
      setState(() {
        hasInternet = false;
      });

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: noNetAlert(context),
          );
        },
      );
    } else {
      setState(() {
        hasInternet = true;
      });

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
    final themeProvider =
        Provider.of<ThemeProvider>(context); // ThemeProvider'ı alın
    final isDarkMode = themeProvider.isDarkMode; // Tema modunu alın
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 170.sp,
          width: 150.sp,
          child: Image.asset(
              isDarkMode ? 'assets/light_SNY.png' : 'assets/SNY.png'),
        ),
      ),
    );
  }
}
