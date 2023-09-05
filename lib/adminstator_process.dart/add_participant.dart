import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/db_helper.dart/db_process.dart';
import 'package:get/get.dart';

import '../widgets/containers.dart';

import 'admin_pop_up.dart/user_popup.dart';

GestureDetector participantAdd(context) {
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  CollectionReference attendance =
      FirebaseFirestore.instance.collection("Users");

  Future<void> addUser() async {
    return await add(context, attendance, myController2, {
      "FullName": myController1.text.toString(),
      "Sicil": myController2.text.toString(),
    });
  }

  Future<void> deleteUser() async {
    return await delete(context, attendance, myController2);
  }

  Future<void> updateUser() async {
    return await update(context, attendance, myController2,
        {'FullName': myController1.text.toString()});
  }

  return GestureDetector(
    onLongPress: () {
      deleteUserPopUp(context, myController2, attendance, deleteUser);
    },
    onTap: () {
      addUserPopUp(context, myController1, myController2, attendance, addUser,
          updateUser);
    },
    child: adminPageContainerDesign("assets/participant.png", 'katilimci'.tr),
  );
}
