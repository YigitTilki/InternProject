// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sanofi_main/widgets/admin_attendance.dart';
import 'package:sanofi_main/widgets/alert_dialog.dart';

import 'package:sanofi_main/widgets/containers.dart';
import 'package:sanofi_main/widgets/dropdown.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';
import 'package:sizer/sizer.dart';

import 'admin_pop_up.dart/lesson_popup.dart';

class LessonAddWidget extends StatefulWidget {
  const LessonAddWidget({super.key});

  @override
  _LessonAddWidgetState createState() => _LessonAddWidgetState();
}

class _LessonAddWidgetState extends State<LessonAddWidget> {
  List<DocumentSnapshot> searchResults = [];

  final lessonController = TextEditingController();
  bool isLessonSelected = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController myController1 = TextEditingController();
    String? selectedLesson;

    CollectionReference attendance =
        FirebaseFirestore.instance.collection("Dersler");

    return GestureDetector(
      onLongPress: () async {
        await lessonAttendanceProcess(context, selectedLesson);
      },
      onTap: () async {
        await addDeleteLessonPopUp(context, myController1, attendance);
      },
      child: adminPageContainerDesign("assets/library.png", 'ders'.tr),
    );
  }

  Future<dynamic> lessonAttendanceProcess(
      BuildContext context, String? selectedLesson) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialogProcess(
            Text(
              'ders'.tr,
              textAlign: TextAlign.center,
              style: Constants.getTextStyle(
                  Theme.of(Get.context!).hintColor, 20.sp),
            ),
            null,
            DropDown(
                selectedLesson: selectedLesson,
                onSelectionChanged: (newValue) {
                  setState(() {
                    selectedLesson = newValue;
                    isLessonSelected = newValue != null;
                  });
                }),
            [
              elevatedButtonProcess(
                const Icon(Icons.check),
                () async {
                  CollectionReference lessonCollect = FirebaseFirestore.instance
                      .collection(selectedLesson.toString());

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AdminAttendanceListBuilder(
                        collectionReference: lessonCollect,
                        colStr: selectedLesson.toString(),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }
}
