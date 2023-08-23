import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_form_field.dart';

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

  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          myController1 = TextEditingController();
          myController2 = TextEditingController();
          myController3 = TextEditingController();

          return alertDialogProcess(
            const Text(
              "Eğitimci Ekle",
              textAlign: TextAlign.center,
            ),
            null,
            Expanded(
              child: SizedBox(
                width: 500,
                height: 250,
                child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: textFormFieldProcess("Ad-Soyad", myController1)),
                    Expanded(
                        flex: 2,
                        child: textFormFieldProcess("Sicil No", myController2)),
                    Expanded(
                        flex: 2,
                        child: textFormFieldProcess("Password", myController3)),
                  ],
                ),
              ),
            ),
            [
              Expanded(
                child: elevatedButtonProcess(
                  const Text("Ekle/Güncelle"),
                  () => FutureBuilder<void>(
                    future: addUserE(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Text('Kod okundu derse girildi');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: elevatedButtonProcess(
                  const Text("Sil"),
                  () => FutureBuilder<void>(
                    future: deleteUserE(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Text('Kullanıcı Silindi');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
    child: Container(
      width: 160,
      height: 99,
      decoration: ShapeDecoration(
        color: const Color(0xCC7B00EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(
              "assets/teacher.png",
              width: 70,
              height: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Eğitimci Ekle",
              style: Constants.getTextStyle(Colors.white, 15.0),
            ),
          ),
        ],
      ),
    ),
  );
}
