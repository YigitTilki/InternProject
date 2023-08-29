import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/pages/login_page_t.dart';
import 'package:sanofi_main/pages/student_page.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../adminstator_process.dart/admin_router.dart';
import '../constants/constants.dart';
import '../widgets/back_buttons.dart';

class LoginPageS extends StatefulWidget {
  const LoginPageS({Key? key}) : super(key: key);

  @override
  State<LoginPageS> createState() => _LoginPageSState();
}

class _LoginPageSState extends State<LoginPageS> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
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
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 100.sp,
                ),
              ),
              Constants.sanofiBig(),
              Text(
                "Eğitim Yoklama Sistemi",
                style: Constants.getTextStyle(Colors.black, 15.0.sp),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50.sp,
                ),
              ),
              textFormFieldProcess("Ad-Soyad", myController1,
                  [UppercaseInputFormatter(), nameFormatter]),
              SizedBox(
                height: 10.sp,
              ),
              textFormFieldProcess("Sicil No", myController2, [sicilFormatter]),
              SizedBox(
                height: 15.sp,
              ),
              SizedBox(
                child: elevatedButtonProcess(
                  Text(
                    "Giriş",
                    style: Constants.getTextStyle(Colors.white, 14.0.sp),
                  ),
                  () async {
                    final sicilNo = myController2.text.toString();

                    if (sicilNo.isNotEmpty) {
                      final docRef = db.collection("Users").doc(sicilNo);

                      try {
                        final doc = await docRef.get();
                        final data = doc.data() as Map<String, dynamic>;

                        if (data["FullName"].toString() ==
                            myController1.text.toString()) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentPage(
                                data1: myController1,
                                data2: myController2,
                              ),
                            ),
                          );
                        } else {
                          debugPrint("olmadı");
                        }
                      } catch (e) {
                        debugPrint("Error: $e");
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sicil No alanını doldurun.'),
                        ),
                      );
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPageT(),
                    ),
                  );
                },
                child: Text(
                  "Eğitimci Girişi",
                  style: Constants.getTextStyle(Colors.black, 12.0.sp),
                ),
              ),
              SizedBox(
                height: 170.sp,
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
