// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sanofi_main/widgets/containers.dart';

import 'admin_pop_up.dart/adddeleteupdate_popup.dart';

GestureDetector lessonAdd(context) {
  TextEditingController myController1 = TextEditingController();

  CollectionReference attendance =
      FirebaseFirestore.instance.collection("Dersler");

  Future<void> addLesson() async {
    try {
      await attendance.doc(myController1.text.toString()).set({
        "Ders": myController1.text.toString(),
      });

      Navigator.pop(context);
    } catch (error) {
      debugPrint("Hata oluştu: $error");
    }
  }

  Future<void> deleteLesson() async {
    try {
      await attendance.doc(myController1.text.toString()).delete();

      Navigator.pop(context);
    } catch (error) {
      debugPrint("Hata oluştu: $error");
    }
  }

  return GestureDetector(
    onTap: () {
      addDeleteLessonPopUp(
          context, myController1, attendance, addLesson, deleteLesson);
    },
    child: adminPageContainerDesign("assets/library.png", "Eğitim"),
  );
}
