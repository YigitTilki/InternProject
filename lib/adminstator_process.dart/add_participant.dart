import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/constants/constants.dart';

import '../widgets/alert_dialog.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_form_field.dart';

GestureDetector attendanceAdd(context) {
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

  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          myController1 = TextEditingController();
          myController2 = TextEditingController();

          return alertDialogProcess(
            Text(
              "Katılımcı",
              textAlign: TextAlign.center,
              style: Constants.getTextStyle(Colors.black, 24.0),
            ),
            null,
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 500,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: textFormFieldProcess("Ad-Soyad", myController1)),
                    Expanded(
                        flex: 2,
                        child: textFormFieldProcess("Sicil No", myController2)),
                  ],
                ),
              ),
            ),
            [
              Expanded(
                child: elevatedButtonProcess(
                  const Text("Ekle/Güncelle"),
                  () => FutureBuilder<void>(
                    future: addUser(),
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
                    future: deleteUser(),
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
      width: 152,
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
              "assets/participant.png",
              height: 70,
              width: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Katılımcı Ekle",
              style: Constants.getTextStyle(Colors.white, 15.0),
            ),
          ),
        ],
      ),
    ),
  );
}
