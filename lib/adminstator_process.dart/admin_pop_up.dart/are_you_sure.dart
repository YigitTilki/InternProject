import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/containers.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';

import '../../constants/constants.dart';

import 'i_am_sure.dart';

Padding areYouSureUser(
    TextEditingController myController1,
    TextEditingController myController2,
    CollectionReference<Object?> collectionReference,
    BuildContext context,
    Future<void> Function() addUser,
    Future<void> Function() updateUser) {
  return areYouSureContainer(
    [
      Text(
        "Ad-Soyad: ${myController1.text.toString()}",
        style: Constants.getTextStyle(Colors.white, 18.0),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Sicil No: ${myController2.text.toString()}",
        style: Constants.getTextStyle(Colors.white, 18.0),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        "Bilgileri onaylıyor musunuz",
        textAlign: TextAlign.center,
        style: Constants.getTextStyle(Colors.white, 24.0),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iAmSureUser(myController1, myController2, collectionReference,
              context, addUser, updateUser),
          const SizedBox(
            width: 15,
          ),
          elevatedButtonProcess(
            Text(
              "İptal",
              style: Constants.getTextStyle(Colors.white, 16.0),
            ),
            () => Navigator.pop(context),
          ),
        ],
      ),
    ],
  );
}
