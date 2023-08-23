import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/adminstator_process.dart/add_lesson.dart';
import 'package:sanofi_main/adminstator_process.dart/add_participant.dart';
import 'package:sanofi_main/adminstator_process.dart/add_teacher.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sanofi_main/widgets/alert_dialog.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(127, 80, 127, 100),
                child: GestureDetector(
                  onDoubleTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alertDialogProcess(
                              Text(
                                "Saygılarla",
                                textAlign: TextAlign.center,
                                style:
                                    Constants.getTextStyle(Colors.black, 36.0),
                              ),
                              null,
                              SizedBox(
                                height: 100,
                                width: 500,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Yiğit Tilki",
                                      style: Constants.getTextStyle(
                                          Colors.black, 15.0),
                                    ),
                                    Text(
                                      "İbrahim Çerkezoğlu",
                                      style: Constants.getTextStyle(
                                          Colors.black, 15.0),
                                    ),
                                  ],
                                ),
                              ),
                              null);
                        });
                  },
                  child: Image.asset(
                    "assets/adminicon.png",
                    height: 95,
                    width: 95,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                attendanceAdd(context),
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
    );
  }
}
