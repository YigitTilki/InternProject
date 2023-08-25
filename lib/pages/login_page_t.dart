// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/dropdown.dart';
import 'package:sanofi_main/pages/login_page_s.dart';

import 'package:sanofi_main/pages/teacher_page.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';

import '../adminstator_process.dart/admin_router.dart';
import '../constants/constants.dart';
import '../widgets/back_buttons.dart';

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

  Future<bool> _onBackPressed() async {
    return await BackFunctions.onBackPressed(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                padding: const EdgeInsets.only(top: 15, bottom: 50),
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
                  onPressed: () async {
                    final docRef = db
                        .collection("UsersE")
                        .doc(myController2.text.toString());
                    try {
                      final doc = await docRef.get();
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
                    } catch (e) {
                      debugPrint("Hata: $e");
                    }
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
                  adminRouter(context, passwordController);
                },
                child: Image.asset(
                  "assets/SNY.png",
                  height: 20,
                  width: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
