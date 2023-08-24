import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/containers.dart';

import '../constants/constants.dart';
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          myController1 = TextEditingController();

          return alertDialogProcess(
            Text(
              "Eğitim",
              textAlign: TextAlign.center,
              style: Constants.getTextStyle(Colors.black, 24.0),
            ),
            null,
            Expanded(
              child: SizedBox(
                width: 500,
                height: 80,
                child: Column(
                  children: [
                    textFormFieldProcess("Eğitim Adı", myController1),
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
                    future: deleteLesson(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Text('Ders Silindi');
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
    child: adminPageContainerDesign("assets/library.png", "Eğitim"),
  );
}
