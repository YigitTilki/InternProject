import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/containers.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';

import '../../constants/constants.dart';

Padding areYouSureUser(
  String? containerText1,
  String? containerText2,
  String? containerText3,
  CollectionReference<Object?> collectionReference,
  BuildContext context,
  Future<void> Function()? deleteUser,
  ElevatedButton iAmSure,
) {
  return areYouSureContainer(
    [
      Text(
        containerText1!,
        style: Constants.getTextStyle(Colors.white, 18.0),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        containerText2!,
        style: Constants.getTextStyle(Colors.white, 18.0),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        containerText3!,
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
          iAmSure,
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
