// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          "Katılımcı Ekle",
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
                  child: textFormFieldProcess("Ad-Soyad", myController1,
                      [UppercaseInputFormatter(), nameFormatter]),
                ),
                Expanded(
                  flex: 2,
                  child: textFormFieldProcess(
                      "Sicil No", myController2, [sicilFormatter]),
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
                style: Constants.getTextStyle(Colors.white, 11.0.sp),
              ),
              () {
                Navigator.pop(context);
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return areYouSureUser(
                      "Ad-Soyad: ${myController1.text.toString()}",
                      "Sicil No: ${myController2.text.toString()}",
                      "",
                      collectionReference,
                      context,
                      null,
                      iAmSureUser(myController1, myController2, null,
                          collectionReference, context, addUser, updateUser),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: backElevatedButton(context, "Geri Dön"),
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
            "Katılımcı Sil",
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
                    "Sicil No", myController2, [sicilFormatter])),
          )),
          [
            Expanded(
              child: elevatedButtonProcess(
                const Text("Sil"),
                () {
                  Navigator.pop(context);
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return areYouSureUser(
                          "Silinecek Kullanıcı: ${myController2.text.toString()}",
                          "",
                          "",
                          collectionReference,
                          context,
                          deleteUser,
                          elevatedButtonProcess(
                            const Text("Onaylıyorum"),
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
                                    return AlertDialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Text(
                                        "Böyle bir sicil no yok",
                                        textAlign: TextAlign.center,
                                        style: Constants.getTextStyle(
                                            Colors.red, 48.0.sp),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        );
                      });
                },
              ),
            ),
            Expanded(
              child: backElevatedButton(context, "Geri Dön"),
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
          "Eğitimci Ekle",
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
                    child: textFormFieldProcess("Ad-Soyad", myController1,
                        [UppercaseInputFormatter(), nameFormatter])),
                Expanded(
                    flex: 2,
                    child: textFormFieldProcess(
                        "Sicil No", myController2, [sicilFormatter])),
                Expanded(
                    flex: 2,
                    child:
                        textFormFieldProcess("Password", myController3, null)),
              ],
            ),
          ),
        ),
        [
          Expanded(
            child: elevatedButtonProcess(
              const Text("Ekle/Güncelle"),
              () {
                Navigator.pop(context);

                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return areYouSureUser(
                        "Ad-Soyad: ${myController1.text.toString()}",
                        "Sicil No: ${myController2.text.toString()}",
                        "Şifre: ${myController3.text.toString()}",
                        attendance,
                        context,
                        null,
                        elevatedButtonProcess(
                          Text(
                            "Onaylıyorum",
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
                                                padding: EdgeInsets.all(8.0.sp),
                                                child: Text(
                                                  "Böyle bir sicil mevcut ismi ve şifreyi güncellemek ister misin?",
                                                  textAlign: TextAlign.center,
                                                  style: Constants.getTextStyle(
                                                      Colors.white, 18.0.sp),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    elevatedButtonProcess(
                                                      const Text("Güncelle"),
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

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 20.sp,
                                                    ),
                                                    backElevatedButton(
                                                        context, "İptal"),
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
                                const SnackBar(
                                  content: Text('Hatalı Giriş.'),
                                ),
                              );
                            }
                          },
                        ));
                  },
                );
              },
            ),
          ),
          Expanded(
            child: backElevatedButton(context, "Geri Dön"),
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
      "Eğitimci Sil",
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
          child: textFormFieldProcess("Sicil No", myController2, null)),
    )),
    [
      Expanded(
        child: elevatedButtonProcess(
          const Text("Sil"),
          () {
            Navigator.pop(context);

            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return areYouSureUser(
                  "Silinecek Kullanıcı: ${myController2.text.toString()}",
                  "",
                  "",
                  attendance,
                  context,
                  deleteUserE,
                  elevatedButtonProcess(
                    const Text("Onaylıyorum"),
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
                            return AlertDialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              title: Text(
                                "Böyle bir sicil no yok",
                                textAlign: TextAlign.center,
                                style:
                                    Constants.getTextStyle(Colors.red, 30.0.sp),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      Expanded(
        child: backElevatedButton(context, "Geri Dön"),
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
          "Eğitim",
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
                textFormFieldProcess("Eğitim Adı", myController1,
                    [UppercaseInputFormatter(), sicilFormatter]),
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
    const Text("Sil"),
    () {
      Navigator.pop(context);
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return areYouSureUser(
            "Silinecek Kullanıcı: ${myController1.text.toString()}",
            "",
            "",
            attendance,
            context,
            null,
            elevatedButtonProcess(
              const Text("Onaylıyorum"),
              () async {
                if (myController1.text.toString().isNotEmpty) {
                  final docRef = attendance.doc(myController1.text.toString());

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
                        return AlertDialog(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                            "Böyle bir ders yok",
                            textAlign: TextAlign.center,
                            style: Constants.getTextStyle(Colors.red, 30.0.sp),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Hatalı Giriş.'),
                    ),
                  );
                }
              },
            ),
          );
        },
      );
    },
  );
}

ElevatedButton addLessonButton(
  BuildContext context,
  TextEditingController myController1,
  CollectionReference<Object?> attendance,
) {
  return elevatedButtonProcess(
    const Text("Ekle"),
    () {
      Navigator.pop(context);
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return areYouSureUser(
            "Eklenilecek Kullanıcı: ${myController1.text.toString()}",
            "",
            "",
            attendance,
            context,
            null,
            elevatedButtonProcess(
              const Text("Onaylıyorum"),
              () async {
                if (myController1.text.toString().isNotEmpty) {
                  final docRef = attendance.doc(myController1.text.toString());

                  try {
                    final doc = await docRef.get();
                    if (doc.exists) {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            title: Text(
                              "Böyle bir ders zaten var",
                              textAlign: TextAlign.center,
                              style:
                                  Constants.getTextStyle(Colors.red, 30.0.sp),
                            ),
                          );
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
                    const SnackBar(
                      content: Text('Hatalı Giriş.'),
                    ),
                  );
                }
              },
            ),
          );
        },
      );
    },
  );
}
