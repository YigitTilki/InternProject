// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanofi_main/widgets/error_alert.dart';
import 'package:sanofi_main/widgets/scaffold_messanger.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/containers.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/text_form_field.dart';
import 'are_you_sure.dart';
import 'i_am_sure.dart';

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
        Expanded(
          flex: 1,
          child: SizedBox(
            width: 500.sp,
            height: 125.sp,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: textFormFieldProcess('ad-soyad'.tr, myController1,
                      [UppercaseInputFormatter(), nameFormatter]),
                ),
                Expanded(
                  flex: 2,
                  child: textFormFieldProcess(
                      'sicil'.tr, myController2, [sicilFormatter]),
                ),
              ],
            ),
          ),
        ),
        [
          Expanded(
            child: elevatedButtonProcess(
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
          ),
          Expanded(
            child: backElevatedButton(context, 'geri-don'.tr),
          ),
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
          Expanded(
              child: SizedBox(
            height: 60.sp,
            width: 500.sp,
            child: Expanded(
                flex: 2,
                child: textFormFieldProcess(
                    'sicil'.tr, myController2, [sicilFormatter])),
          )),
          [
            Expanded(
              child: elevatedButtonProcess(
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
            ),
            Expanded(
              child: backElevatedButton(context, 'geri-don'.tr),
            ),
          ],
        );
      });
}

Future<dynamic> addUserEpopUp(
    context,
    TextEditingController myController1,
    TextEditingController myController2,
    TextEditingController myController3,
    CollectionReference<Object?> attendance,
    Future<void> Function() addUserE,
    Future<void> Function() updateUserE) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      myController1 = TextEditingController();
      myController2 = TextEditingController();
      myController3 = TextEditingController();

      return alertDialogProcess(
        Text(
          'egitimci-ekle'.tr,
          textAlign: TextAlign.center,
          style: Constants.getTextStyle(Colors.black, 20.0.sp),
        ),
        null,
        Expanded(
          child: SizedBox(
            width: 500.sp,
            height: 175.sp,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: textFormFieldProcess('ad-soyad'.tr, myController1,
                        [UppercaseInputFormatter(), nameFormatter])),
                Expanded(
                    flex: 2,
                    child: textFormFieldProcess(
                        'sicil'.tr, myController2, [sicilFormatter])),
                Expanded(
                    flex: 2,
                    child:
                        textFormFieldProcess('sifre'.tr, myController3, null)),
              ],
            ),
          ),
        ),
        [
          Expanded(
            child: elevatedButtonProcess(
              Text('ekle-guncelle'.tr),
              () {
                if (myController1.text.toString().isNotEmpty &&
                    myController2.text.toString().isNotEmpty &&
                    myController3.text.toString().isNotEmpty) {
                  Navigator.pop(context);

                  return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return areYouSureUser(
                          "${'ad-soyad:'.tr}${myController1.text.toString()}",
                          "${'sicil:'.tr}${myController2.text.toString()}",
                          "${'sifre:'.tr}${myController3.text.toString()}",
                          attendance,
                          context,
                          null,
                          elevatedButtonProcess(
                            Text(
                              'onay'.tr,
                              style:
                                  Constants.getTextStyle(Colors.white, 11.0.sp),
                            ),
                            () async {
                              final sicilNo = myController2.text.toString();
                              final adSoyad = myController1.text.toString();
                              final password = myController3.text.toString();

                              if (sicilNo.isNotEmpty &&
                                  adSoyad.isNotEmpty &&
                                  password.isNotEmpty) {
                                final docRef = attendance.doc(sicilNo);

                                try {
                                  final doc = await docRef.get();
                                  if (doc.exists) {
                                    final data =
                                        doc.data() as Map<String, dynamic>;

                                    if (data != null &&
                                        data["Sicil"].toString() == sicilNo) {
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
                                                  padding:
                                                      EdgeInsets.all(8.0.sp),
                                                  child: Text(
                                                    'sicil-mevcut-ismi-ve-sifre-gunc'
                                                        .tr,
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        Constants.getTextStyle(
                                                            Colors.white,
                                                            18.0.sp),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      elevatedButtonProcess(
                                                        Text('güncelle'.tr),
                                                        () async {
                                                          await attendance
                                                              .doc(myController2
                                                                  .text
                                                                  .toString())
                                                              .update({
                                                                'FullName':
                                                                    myController1
                                                                        .text
                                                                        .toString(),
                                                                "Password":
                                                                    myController3
                                                                        .text
                                                                        .toString()
                                                              })
                                                              .then((value) =>
                                                                  debugPrint(
                                                                      "Updated"))
                                                              .catchError((error) =>
                                                                  debugPrint(
                                                                      "Failed to update : $error"));

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 20.sp,
                                                      ),
                                                      backElevatedButton(
                                                          context, 'iptal'.tr),
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
                                    await attendance
                                        .doc(myController2.text.toString())
                                        .set({
                                      "FullName": myController1.text.toString(),
                                      "Sicil": myController2.text.toString(),
                                      "Password": myController3.text.toString()
                                    });
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
                          ));
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: backElevatedButton(context, 'geri-don'.tr),
          ),
        ],
      );
    },
  );
}

AlertDialog deleteUserEpopUp(
    TextEditingController myController2,
    BuildContext context,
    CollectionReference<Object?> attendance,
    Future<void> Function() deleteUserE) {
  return alertDialogProcess(
    Text(
      'egitimci-sil'.tr,
      textAlign: TextAlign.center,
      style: Constants.getTextStyle(Colors.black, 20.0.sp),
    ),
    null,
    Expanded(
        child: SizedBox(
      height: 60.sp,
      width: 500.sp,
      child: Expanded(
          flex: 2,
          child: textFormFieldProcess('sicil'.tr, myController2, null)),
    )),
    [
      Expanded(
        child: elevatedButtonProcess(
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
                    attendance,
                    context,
                    deleteUserE,
                    elevatedButtonProcess(
                      Text('onay'.tr),
                      () async {
                        final docRef =
                            attendance.doc(myController2.text.toString());

                        final doc = await docRef.get();

                        if (doc.exists) {
                          await attendance
                              .doc(myController2.text.toString())
                              .delete();
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return errorAlertDialog('boyle-sicil-yok'.tr);
                            },
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
        ),
      ),
      Expanded(
        child: backElevatedButton(context, 'geri-don'.tr),
      ),
    ],
  );
}

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
