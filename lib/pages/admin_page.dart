// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/adminstator_process.dart/add_lesson.dart';
import 'package:sanofi_main/adminstator_process.dart/add_participant.dart';
import 'package:sanofi_main/adminstator_process.dart/add_teacher.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sanofi_main/widgets/connection_popup.dart';

import 'package:sizer/sizer.dart';

import '../widgets/arrow_back.dart';
import '../widgets/back_buttons.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool hasInternet = true; // Başlangıçta internetin olduğunu varsayalım
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    // İnternet bağlantısını sürekli izlemek için listener ekleyin
    wifiConnector();
  }

  StreamSubscription<ConnectivityResult> wifiConnector() {
    return Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        // İnternet bağlantısı yoksa hasInternet'i false olarak ayarla
        setState(() {
          hasInternet = false;
        });
        // İnternet bağlantısı kesildiğinde popup göster
        showNoInternetDialog(context);
      } else {
        // İnternet bağlantısı varsa hasInternet'i true olarak ayarla
        setState(() {
          hasInternet = true;
        });
      }
    });
  }

  Future<bool> _onBackPressed() async {
    return await BackFunctions.onBackPressed(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: arrowBackAdmin(context),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(127, 50, 127, 100),
                  child: GestureDetector(
                    onDoubleTap: () => _showDeveloperNamesDialog(context),
                    child: Image.asset(
                      "assets/adminicon.png",
                      height: 80.sp,
                      width: 80.sp,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  participantAdd(context),
                  lessonAdd(context),
                ],
              ),
              SizedBox(
                height: 21.sp,
              ),
              teacherAdd(context),
              Expanded(flex: 1, child: Constants.sanofiBig())
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeveloperNamesDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Saygılarla',
            style: Constants.getTextStyle(Colors.black, 20.sp),
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Yiğit Tilki',
                style: Constants.getTextStyle(Colors.black, 15.sp),
              ),
            ),
            Center(
              child: Text(
                'İbrahim Çerkezoğlu',
                style: Constants.getTextStyle(Colors.black, 15.sp),
              ),
            ),
            // Add more developer names here as needed
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: Constants.getTextStyle(Colors.black, 10.sp),
            ),
          ),
        ],
      );
    },
  );
}
