// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/containers.dart';

import 'admin_pop_up.dart/adddeleteupdate_popup.dart';

GestureDetector teacherAdd(context) {
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  TextEditingController myController3 = TextEditingController();

  CollectionReference attendance =
      FirebaseFirestore.instance.collection("UsersE");

  Future<void> addUserE() async {
    try {
      await attendance.doc(myController2.text.toString()).set({
        "FullName": myController1.text.toString(),
        "Sicil": myController2.text.toString(),
        "Password": myController3.text.toString()
      });

      Navigator.pop(context);
    } catch (error) {
      debugPrint("Hata oluştu: $error");
    }
  }

  Future<void> deleteUserE() async {
    try {
      await attendance.doc(myController2.text.toString()).delete();

      Navigator.pop(context);
    } catch (error) {
      debugPrint("Hata oluştu: $error");
    }
  }

  Future<void> updateUserE() {
    return attendance
        .doc(myController2.text.toString())
        .update({
          'FullName': myController1.text.toString(),
          "Password": myController3.text.toString()
        })
        .then((value) => debugPrint("User Updated"))
        .catchError((error) => debugPrint("Failed to update user: $error"));
  }

  return GestureDetector(
    onLongPress: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            myController2 = TextEditingController();

            return deleteUserEpopUp(
                myController2, context, attendance, deleteUserE);
          });
    },
    onTap: () {
      addUserEpopUp(context, myController1, myController2, myController3,
          attendance, addUserE, updateUserE);
    },
    child: adminPageContainerDesign("assets/teacher.png", "Eğitimci"),
  );
}
