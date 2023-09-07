// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sanofi_main/adminstator_process.dart/add_lesson.dart';
import 'package:sanofi_main/adminstator_process.dart/add_participant.dart';
import 'package:sanofi_main/adminstator_process.dart/add_teacher.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sanofi_main/widgets/connection_popup.dart';

import 'package:sizer/sizer.dart';

import '../provider/theme_provider.dart';
import '../widgets/arrow_back.dart';
import '../widgets/back_buttons.dart';
import '../widgets/show_developers.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();

    wifiConnector();
  }

  StreamSubscription<ConnectivityResult> wifiConnector() {
    return Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          hasInternet = false;
        });

        showNoInternetDialog(context);
      } else {
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
    final themeProvider =
        Provider.of<ThemeProvider>(context); // ThemeProvider'ı alın
    final isDarkMode = themeProvider.isDarkMode; // Tema modunu alın
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
                  padding: EdgeInsets.fromLTRB(70.sp, 40.sp, 70.sp, 40.sp),
                  child: GestureDetector(
                    onDoubleTap: () => showDeveloperNamesDialog(context),
                    child: Image.asset(
                      isDarkMode
                          ? 'assets/light_adminicon.png'
                          : 'assets/adminicon.png',
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
                  const LessonAddWidget(),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              teacherAdd(context),
              Expanded(flex: 1, child: Constants.sanofiBig(context))
            ],
          ),
        ),
      ),
    );
  }
}
