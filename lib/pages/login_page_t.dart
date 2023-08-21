import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/dropdown.dart';
import 'package:sanofi_main/pages/login_page_s.dart';

import 'package:sanofi_main/pages/teacher_page.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    final docRef = db.collection("UsersE").doc("1");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Expanded(
              child: SizedBox(
                height: 119,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: SizedBox(
                height: 51.56,
                width: 200,
                child: Image.asset("assets/SNY_BIG.png"),
              ),
            ),
            const Text("Eğitim Yoklama Sistemi"),
            const Expanded(
              child: SizedBox(
                height: 227,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, top: 5),
              child: textFormFieldProcess("Ad-Soyad", myController1),
            ),
            const Expanded(
              child: SizedBox(
                height: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, top: 5),
              child: textFormFieldProcess("Sicil No", myController2),
            ),
            const Expanded(
              child: SizedBox(
                height: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, top: 5),
              child: textFormFieldProcess("Şifre", myController3),
            ),
            const Expanded(
              child: SizedBox(
                height: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.0, left: 25, top: 5),
              child: DropDown(
                  selectedLesson: selectedLesson,
                  onSelectionChanged: (newValue) {
                    setState(() {
                      selectedLesson = newValue;
                    });
                  }),
            ),
            const Expanded(
              child: SizedBox(
                height: 20,
              ),
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
                child: const Text(
                  "Giriş",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 10,
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
              child: const Text(
                "Öğrenci Girişi",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
