// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/dropdown.dart';
import 'package:sanofi_main/pages/login_page_s.dart';
import 'package:get/get.dart';

import 'package:sanofi_main/pages/teacher_page.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../adminstator_process.dart/admin_router.dart';
import '../constants/constants.dart';
import '../widgets/back_buttons.dart';
import '../widgets/scaffold_messanger.dart';

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
  bool isLessonSelected =
      false; // Ders seçilip seçilmediğini kontrol etmek için

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
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 100.sp,
                ),
              ),
              Constants.sanofiBig(),
              Text(
                "egitim".tr,
                style: Constants.getTextStyle(Colors.black, 15.0.sp),
              ),
              Expanded(
                child: SizedBox(
                  height: 70.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                child: DropDown(
                    selectedLesson: selectedLesson,
                    onSelectionChanged: (newValue) {
                      setState(() {
                        selectedLesson = newValue;
                        isLessonSelected = newValue != null;
                      });
                    }),
              ),
              textFormFieldProcess('ad-soyad'.tr, myController1,
                  [UppercaseInputFormatter(), nameFormatter]),
              SizedBox(
                height: 10.sp,
              ),
              textFormFieldProcess('sicil'.tr, myController2, [sicilFormatter]),
              SizedBox(
                height: 10.sp,
              ),
              textFormFieldProcess("sifre".tr, myController3, null),
              SizedBox(
                height: 50.sp,
              ),
              SizedBox(
                  child: elevatedButtonProcess(
                Text(
                  "giris".tr,
                  style: Constants.getTextStyle(Colors.white, 12.sp),
                ),
                () async {
                  if (isLessonSelected &&
                      myController2.text.isNotEmpty &&
                      myController1.text.toString().isNotEmpty &&
                      myController3.text.toString().isNotEmpty) {
                    final docRef = db
                        .collection("UsersE")
                        .doc(myController2.text.toString());
                    try {
                      final doc = await docRef.get();
                      if (doc.exists) {
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
                          return ScaffoldMessenger.of(context).showSnackBar(
                            snackBar(),
                          );
                        }
                      } else {
                        return ScaffoldMessenger.of(context).showSnackBar(
                          snackBar(),
                        );
                      }
                    } catch (e) {
                      debugPrint("Hata: $e");
                    }
                  } else {
                    return ScaffoldMessenger.of(context).showSnackBar(
                      snackBar(),
                    );
                  }
                },
              )),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPageS(),
                    ),
                  );
                },
                child: Text(
                  'ogrenci-giris'.tr,
                  style: Constants.getTextStyle(Colors.black, 12.0.sp),
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
              GestureDetector(
                onLongPress: () {
                  adminRouter(context, passwordController);
                },
                child: Image.asset(
                  "assets/SNY.png",
                  height: 20.sp,
                  width: 20.sp,
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 25.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
