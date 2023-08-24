import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/containers.dart';

import 'admin_pop_up.dart/adddelete_user_popup.dart';

GestureDetector participantAdd(context) {
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  CollectionReference attendance =
      FirebaseFirestore.instance.collection("Users");

  Future<void> addUser() async {
    try {
      await attendance.doc(myController2.text.toString()).set({
        "FullName": myController1.text.toString(),
        "Sicil": myController2.text.toString(),
      });

      Navigator.pop(context);
    } catch (error) {
      debugPrint("Hata oluştu: $error");
    }
  }

  Future<void> deleteUser() async {
    try {
      await attendance.doc(myController2.text.toString()).delete();

      Navigator.pop(context);
    } catch (error) {
      debugPrint("Hata oluştu: $error");
    }
  }

  Future<void> updateUser() {
    return attendance
        .doc(myController2.text.toString())
        .update({'FullName': myController1.text.toString()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  return GestureDetector(
    onLongPress: () {
      deleteUserPopUp(context, myController2, deleteUser);
    },
    onTap: () {
      addUserPopUp(context, myController1, myController2, attendance, addUser,
          updateUser);
    },
    child: adminPageContainerDesign("assets/participant.png", "Katılımcı"),
  );
}
