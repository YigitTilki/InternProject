// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../db_helper.dart/db_process.dart';
import '../widgets/containers.dart';
import 'admin_pop_up.dart/user_e_popup.dart';

GestureDetector teacherAdd(context) {
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  TextEditingController myController3 = TextEditingController();

  CollectionReference attendance =
      FirebaseFirestore.instance.collection("UsersE");

  Future<void> addUserE() async {
    return await add(context, attendance, myController2, {
      "FullName": myController1.text.toString(),
      "Sicil": myController2.text.toString(),
      "Password": myController3.text.toString()
    });
  }

  Future<void> deleteUserE() async {
    return await delete(context, attendance, myController2);
  }

  Future<void> updateUserE() async {
    return await update(context, attendance, myController2, {
      'FullName': myController1.text.toString(),
      "Password": myController3.text.toString()
    });
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
    child: adminPageContainerDesign("assets/teacher.png", 'egitimci'.tr),
  );
}
