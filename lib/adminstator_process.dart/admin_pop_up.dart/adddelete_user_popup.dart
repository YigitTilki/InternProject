import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/text_form_field.dart';
import 'are_you_sure.dart';

Future<dynamic> addUserPopUp(
    context,
    TextEditingController myController1,
    TextEditingController myController2,
    CollectionReference<Object?> collectionReference,
    Future<void> Function() addUser,
    Future<void> Function() updateUser) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      myController1.clear();
      myController2.clear();

      return alertDialogProcess(
        Text(
          "Katılımcı Ekle",
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
                  child: textFormFieldProcess("Ad-Soyad", myController1),
                ),
                Expanded(
                  flex: 2,
                  child: textFormFieldProcess("Sicil No", myController2),
                ),
              ],
            ),
          ),
        ),
        [
          Expanded(
            child: elevatedButtonProcess(
              Text(
                "Ekle/Güncelle",
                style: Constants.getTextStyle(Colors.white, 13.0),
              ),
              () {
                Navigator.pop(context);
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return areYouSureUser(myController1, myController2,
                        collectionReference, context, addUser, updateUser);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: elevatedButtonProcess(
              Text(
                "Geri Dön",
                style: Constants.getTextStyle(Colors.white, 13.0),
              ),
              () => Navigator.pop(context),
            ),
          ),
        ],
      );
    },
  );
}

Future<dynamic> deleteUserPopUp(context, TextEditingController myController2,
    Future<void> Function() deleteUser) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        myController2.clear();

        return alertDialogProcess(
          Text(
            "Katılımcı Sil",
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
      });
}
