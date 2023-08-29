// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/adminstator_process.dart/add_lesson.dart';
import 'package:sanofi_main/adminstator_process.dart/add_participant.dart';
import 'package:sanofi_main/adminstator_process.dart/add_teacher.dart';
import 'package:sanofi_main/constants/constants.dart';

import 'package:sizer/sizer.dart';

import '../widgets/arrow_back.dart';
import '../widgets/back_buttons.dart';

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
                  child: Image.asset(
                    "assets/adminicon.png",
                    height: 80.sp,
                    width: 80.sp,
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
