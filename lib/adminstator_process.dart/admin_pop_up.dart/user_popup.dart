// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/error_alert.dart';
import '../../widgets/scaffold_messanger.dart';
import '../../widgets/text_form_field.dart';
import 'widgets/are_you_sure.dart';
import 'widgets/i_am_sure.dart';

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
          'katilimci-ekle'.tr,
          textAlign: TextAlign.center,
          style: Constants.getTextStyle(Colors.black, 20.0.sp),
        ),
        null,
        SizedBox(
          height: 150,
          width: 500,
          child: Column(
            children: [
              Expanded(
                child: textFormFieldProcess('ad-soyad'.tr, myController1,
                    [UppercaseInputFormatter(), nameFormatter]),
              ),
              Expanded(
                  child: textFormFieldProcess(
                      'sicil'.tr, myController2, [sicilFormatter])),
            ],
          ),
        ),
        [
          elevatedButtonProcess(
            Text(
              'ekle-guncelle'.tr,
              style: Constants.getTextStyle(Colors.white, 11.0.sp),
            ),
            () {
              if (myController1.text.toString().isNotEmpty &&
                  myController2.text.toString().isNotEmpty) {
                Navigator.pop(context);
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return areYouSureUser(
                      "${'ad-soyad:'.tr}${myController1.text.toString()}",
                      "${'sicil:'.tr}${myController2.text.toString()}",
                      "",
                      collectionReference,
                      context,
                      null,
                      iAmSureUser(myController1, myController2, null,
                          collectionReference, context, addUser, updateUser),
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBar(),
                );
              }
            },
          ),
          backElevatedButton(context, 'geri-don'.tr),
        ],
      );
    },
  );
}

Future<dynamic> deleteUserPopUp(context, TextEditingController myController2,
    collectionReference, Future<void> Function() deleteUser) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        myController2.clear();

        return alertDialogProcess(
          Text(
            'katilimci-sil'.tr,
            textAlign: TextAlign.center,
            style: Constants.getTextStyle(Colors.black, 20.0.sp),
          ),
          null,
          SizedBox(
            height: 60.sp,
            width: 500.sp,
            child: textFormFieldProcess(
                'sicil'.tr, myController2, [sicilFormatter]),
          ),
          [
            elevatedButtonProcess(
              Text('sil'.tr),
              () {
                if (myController2.text.toString().isNotEmpty) {
                  Navigator.pop(context);
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return areYouSureUser(
                          "${'silinecek-kullanici'.tr}${myController2.text.toString()}",
                          "",
                          "",
                          collectionReference,
                          context,
                          deleteUser,
                          elevatedButtonProcess(
                            Text('onay'.tr),
                            () async {
                              final docRef = collectionReference
                                  .doc(myController2.text.toString());

                              final doc = await docRef.get();

                              if (doc.exists) {
                                Navigator.pop(context);
                                await docRef.delete();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return errorAlertDialog(
                                        'boyle-sicil-yok'.tr);
                                  },
                                );
                              }
                            },
                          ),
                        );
                      });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(),
                  );
                }
              },
            ),
            backElevatedButton(context, 'geri-don'.tr),
          ],
        );
      });
}
