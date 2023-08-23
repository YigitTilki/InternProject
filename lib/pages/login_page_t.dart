import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/dropdown.dart';
import 'package:sanofi_main/pages/admin_page.dart';
import 'package:sanofi_main/pages/login_page_s.dart';

import 'package:sanofi_main/pages/teacher_page.dart';
import 'package:sanofi_main/widgets/alert_dialog.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';

import '../constants/constants.dart';

class LoginPageT extends StatefulWidget {
  const LoginPageT({super.key});

  @override
  State<LoginPageT> createState() => _LoginPageTState();
}

class _LoginPageTState extends State<LoginPageT> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  String? selectedLesson;
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String password = "sifre";
    final docRef = db.collection("UsersE").doc("1");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            const Expanded(
              child: SizedBox(
                height: 100,
              ),
            ),
            Constants.sanofiBig(),
            Text(
              "Eğitim Yoklama Sistemi",
              style: Constants.getTextStyle(Colors.black, 15.0),
            ),
            const Expanded(
              child: SizedBox(
                height: 100,
              ),
            ),
            textFormFieldProcess("Ad-Soyad", myController1),
            const SizedBox(
              height: 10,
            ),
            textFormFieldProcess("Sicil No", myController2),
            const SizedBox(
              height: 10,
            ),
            textFormFieldProcess("Şifre", myController3),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 25.0, left: 25, top: 15, bottom: 50),
              child: DropDown(
                  selectedLesson: selectedLesson,
                  onSelectionChanged: (newValue) {
                    setState(() {
                      selectedLesson = newValue;
                    });
                  }),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 200), () async {
                    await docRef.get().then((DocumentSnapshot doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      if (data["FullName"].toString() ==
                              myController1.text.toString() &&
                          data["Sicil"].toString() ==
                              myController2.text.toString() &&
                          data["Password"].toString() ==
                              myController3.text.toString()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeacherPage(
                              data1: myController1,
                              data2: myController2,
                              data3: myController3,
                              data4: selectedLesson,
                            ),
                          ),
                        );
                      } else {
                        debugPrint("olmadı");
                      }
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    minimumSize: const Size(100, 35)),
                child: Text(
                  "Giriş",
                  style: Constants.getTextStyle(Colors.white, 16.0),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPageS(),
                  ),
                );
              },
              child: Text(
                "Öğrenci Girişi",
                style: Constants.getTextStyle(Colors.black, 14.0),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alertDialogProcess(
                      null,
                      const Icon(Icons.lock_outlined),
                      SizedBox(
                        width: 400,
                        child: textFormFieldProcess(
                            "Admin Password", passwordController),
                      ),
                      [
                        elevatedButtonProcess(
                          Text(
                            "Giriş",
                            style: Constants.getTextStyle(Colors.white, 16.0),
                          ),
                          () {
                            if (passwordController.text.toString() ==
                                password) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const AdminPage(),
                                ),
                              );
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
                                      "Şifre Hatalı",
                                      style: Constants.getTextStyle(
                                          Colors.red, 48.0),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Image.asset(
                "assets/SNY.png",
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
