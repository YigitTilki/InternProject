// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sanofi_main/widgets/containers.dart';

import '../db_helper.dart/db_process.dart';
import 'admin_pop_up.dart/adddeleteupdate_popup.dart';

GestureDetector lessonAdd(context) {
  TextEditingController myController1 = TextEditingController();

  CollectionReference attendance =
      FirebaseFirestore.instance.collection("Dersler");

  Future<void> addLesson() async {
    return await add(context, attendance, myController1, {
      "Ders": myController1.text.toString(),
    });
  }

  Future<void> deleteLesson() async {
    return await delete(context, attendance, myController1);
  }

  return GestureDetector(
    onTap: () {
      addDeleteLessonPopUp(
          context, myController1, attendance, addLesson, deleteLesson);
    },
    child: adminPageContainerDesign("assets/library.png", "Eğitim"),
  );
}
