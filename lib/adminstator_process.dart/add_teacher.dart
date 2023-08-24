import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/containers.dart';

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
    onLongPress: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            myController2 = TextEditingController();

            return alertDialogProcess(
              Text(
                "Eğitimci Sil",
                textAlign: TextAlign.center,
                style: Constants.getTextStyle(Colors.black, 24.0),
              ),
              null,
              Expanded(
                  child: SizedBox(
                height: 80,
                width: 500,
                child: Expanded(
                    flex: 2,
                    child: textFormFieldProcess("Sicil No", myController2)),
              )),
              [
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
          });
    },
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          myController1 = TextEditingController();
          myController2 = TextEditingController();
          myController3 = TextEditingController();

          return alertDialogProcess(
            Text(
              "Eğitimci Ekle",
              textAlign: TextAlign.center,
              style: Constants.getTextStyle(Colors.black, 24.0),
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
            ],
          );
        },
      );
    },
    child: adminPageContainerDesign("assets/teacher.png", "Eğitimci"),
  );
}
