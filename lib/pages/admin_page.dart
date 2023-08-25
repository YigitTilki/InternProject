// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/adminstator_process.dart/add_lesson.dart';
import 'package:sanofi_main/adminstator_process.dart/add_participant.dart';
import 'package:sanofi_main/adminstator_process.dart/add_teacher.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sanofi_main/pages/login_page_t.dart';

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

  Future<bool> _onBackPressedFromAppBar() async {
    bool shouldNavigate = await BackFunctions.onBackPressedFromAppBar(context);

    if (shouldNavigate) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPageT()),
      );
    }

    return shouldNavigate;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: arrowBack(),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(127, 50, 127, 100),
                  child: Image.asset(
                    "assets/adminicon.png",
                    height: 95,
                    width: 95,
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
              const SizedBox(
                height: 21,
              ),
              teacherAdd(context),
              Expanded(flex: 1, child: Constants.sanofiBig())
            ],
          ),
        ),
      ),
    );
  }

  AppBar arrowBack() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 40,
          ),
        ),
        onPressed: () {
          _onBackPressedFromAppBar();
        },
      ),
    );
  }
}
