// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanofi_main/widgets/error_alert.dart';
import 'package:sanofi_main/widgets/scaffold_messanger.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/text_form_field.dart';
import 'widgets/are_you_sure.dart';

Future<dynamic> addDeleteLessonPopUp(
  context,
  TextEditingController myController1,
  CollectionReference<Object?> attendance,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      myController1 = TextEditingController();

      return alertDialogProcess(
        Text(
          'ders'.tr,
          textAlign: TextAlign.center,
          style: Constants.getTextStyle(Colors.black, 20.0.sp),
        ),
        null,
        Expanded(
          child: SizedBox(
            width: 500.sp,
            height: 60.sp,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: textFormFieldProcess('egitim-ad'.tr, myController1,
                      [UppercaseInputFormatter(), sicilFormatter]),
                ),
              ],
            ),
          ),
        ),
        [
          Expanded(
            child: addLessonButton(context, myController1, attendance),
          ),
          Expanded(
            child: deleteLessonButton(context, myController1, attendance),
          ),
        ],
      );
    },
  );
}

ElevatedButton deleteLessonButton(
  BuildContext context,
  TextEditingController myController1,
  CollectionReference<Object?> attendance,
) {
  return elevatedButtonProcess(
    Text('sil'.tr),
    () {
      if (myController1.text.toString().isNotEmpty) {
        Navigator.pop(context);
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return areYouSureUser(
              "${'silinecek-kullanici'.tr}${myController1.text.toString()}",
              "",
              "",
              attendance,
              context,
              null,
              elevatedButtonProcess(
                Text('onay'.tr),
                () async {
                  if (myController1.text.toString().isNotEmpty) {
                    final docRef =
                        attendance.doc(myController1.text.toString());

                    // Dökümanı veritabanından alın.
                    final doc = await docRef.get();
                    if (doc.exists) {
                      await attendance
                          .doc(myController1.text.toString())
                          .delete();

                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return errorAlertDialog('boyle-ders-yok'.tr);
                        },
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBar(),
                    );
                  }
                },
              ),
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar(),
        );
      }
    },
  );
}

ElevatedButton addLessonButton(
  BuildContext context,
  TextEditingController myController1,
  CollectionReference<Object?> attendance,
) {
  return elevatedButtonProcess(
    Text('ekle'.tr),
    () {
      if (myController1.text.toString().isNotEmpty) {
        Navigator.pop(context);
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return areYouSureUser(
              "${'eklenecek-kullanici'.tr}${myController1.text.toString()}",
              "",
              "",
              attendance,
              context,
              null,
              elevatedButtonProcess(
                Text('onay'.tr),
                () async {
                  if (myController1.text.toString().isNotEmpty) {
                    final docRef =
                        attendance.doc(myController1.text.toString());

                    try {
                      final doc = await docRef.get();
                      if (doc.exists) {
                        Navigator.pop(context);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return errorAlertDialog('boyle-egitim-var'.tr);
                          },
                        );
                      } else {
                        await attendance
                            .doc(myController1.text.toString())
                            .set({"Ders": myController1.text.toString()});
                        Navigator.pop(context);
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
              ),
            );
          },
        );
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          snackBar(),
        );
      }
    },
  );
}
