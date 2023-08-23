import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          myController1 = TextEditingController();
          myController2 = TextEditingController();

          return alertDialogProcess(
            const Text(
              "Katılımcı Ekle",
              textAlign: TextAlign.center,
            ),
            null,
            Expanded(
              child: SizedBox(
                width: 500,
                height: 150,
                child: Column(
                  children: [
                    textFormFieldProcess("Ad-Soyad", myController1),
                    textFormFieldProcess("Sicil No", myController2),
                  ],
                ),
              ),
            ),
            [
              Expanded(
                  child: elevatedButtonProcess(
                      const Text("Ekle"),
                      () => FutureBuilder<void>(
                            future: addUser(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return const Text('Kod okundu derse girildi');
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          )))
            ],
          );
        },
      );
    },
    child: Container(
      width: 152,
      height: 99,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Image.asset("assets/participant.png"),
    ),
  );
}
