// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';

import '../../../widgets/containers.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/scaffold_messanger.dart';

ElevatedButton iAmSureUser(
    TextEditingController myController1,
    TextEditingController myController2,
    TextEditingController? myController3,
    CollectionReference<Object?> collectionReference,
    BuildContext context,
    Future<void> Function() addUser,
    Future<void> Function() updateUser) {
  return elevatedButtonProcess(
    Text(
      'onay'.tr,
      style: Constants.getTextStyle(Colors.white, 11.0.sp),
    ),
    () async {
      final sicilNo = myController2.text.toString();
      final adSoyad = myController1.text.toString();

      if (sicilNo.isNotEmpty && adSoyad.isNotEmpty) {
        final docRef = collectionReference.doc(sicilNo);

        try {
          final doc = await docRef.get();
          if (doc.exists) {
            final data = doc.data() as Map<String, dynamic>;

            if (data != null && data["Sicil"].toString() == sicilNo) {
              Navigator.pop(context);

              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return areYouSureContainer(
                    [
                      SizedBox(
                        height: 50.sp,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Text(
                            'sicil-mevcut'.tr,
                            textAlign: TextAlign.center,
                            style:
                                Constants.getTextStyle(Colors.white, 18.0.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              elevatedButtonProcess(
                                Text('güncelle'.tr),
                                () async {
                                  await updateUser();

                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                width: 20.sp,
                              ),
                              backElevatedButton(context, 'iptal'.tr),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.sp,
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            await addUser();
          }
        } catch (e) {
          debugPrint("Error: $e");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar(),
        );
      }
    },
  );
}
