import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/alert_dialog.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_form_field.dart';

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

  return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            myController1 = TextEditingController();

            return alertDialogProcess(
              const Text(
                "Ders Ekle",
                textAlign: TextAlign.center,
              ),
              null,
              Expanded(
                child: SizedBox(
                  width: 500,
                  height: 100,
                  child: Column(
                    children: [
                      textFormFieldProcess("Ders Ekle", myController1),
                    ],
                  ),
                ),
              ),
              [
                Expanded(
                    child: elevatedButtonProcess(
                        const Text("Ekle"),
                        () => FutureBuilder<void>(
                              future: addLesson(),
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
        child: Image.asset("assets/library.png"),
      ));
}
