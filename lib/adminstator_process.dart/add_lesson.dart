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

  return GestureDetector(
    onTap: () async {
      await addDeleteLessonPopUp(context, myController1, attendance);
    },
    child: adminPageContainerDesign("assets/library.png", "Eğitim"),
  );
}
