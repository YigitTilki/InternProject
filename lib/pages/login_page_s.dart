// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sanofi_main/pages/login_page_t.dart';
import 'package:sanofi_main/pages/student_page.dart';
import 'package:sanofi_main/widgets/connection_popup.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../adminstator_process.dart/admin_router.dart';
import '../constants/constants.dart';
import '../provider/theme_provider.dart';
import '../widgets/back_buttons.dart';
import '../widgets/scaffold_messanger.dart';
import '../widgets/text_button_process.dart';

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
  void initState() {
    super.initState();

    wifiConnector();
  }

  StreamSubscription<ConnectivityResult> wifiConnector() {
    return Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          hasInternet = false;
        });

        showNoInternetDialog(context);
      } else {
        setState(() {
          hasInternet = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // ThemeProvider'ı alın
    final isDarkMode = themeProvider.isDarkMode; // Tema modunu alın
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
              Constants.sanofiBig(context),
              Text(
                'egitim'.tr,
                style: Constants.getTextStyle(
                    Theme.of(Get.context!).hintColor, 15.0.sp),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50.sp,
                ),
              ),
              textFormFieldProcess(
                'ad-soyad'.tr,
                myController1,
                [UppercaseInputFormatter(), nameFormatter],
              ),
              SizedBox(
                height: 10.sp,
              ),
              textFormFieldProcess(
                'sicil'.tr,
                myController2,
                [sicilFormatter],
              ),
              SizedBox(
                height: 60.sp,
              ),
              SizedBox(
                child: loginButton(context),
              ),
              textButton(context, const LoginPageT(), "egitimci-giris"),
              SizedBox(
                height: 90.sp,
              ),
              GestureDetector(
                onLongPress: () {
                  adminRouter(context, passwordController);
                },
                child: Image.asset(
                  isDarkMode ? 'assets/light_SNY.png' : 'assets/SNY.png',
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

  ElevatedButton loginButton(BuildContext context) {
    return elevatedButtonProcess(
      Text(
        'giris'.tr,
        style: Constants.getTextStyle(Colors.white, 12.0.sp),
      ),
      () async {
        final sicilNo = myController2.text.toString();
        final fullName = myController1.text.toString();

        if (sicilNo.isNotEmpty && fullName.isNotEmpty) {
          final docRef = db.collection("Users").doc(sicilNo);

          try {
            final doc = await docRef.get();

            if (doc.exists) {
              final data = doc.data() as Map<String, dynamic>;

              if (data != null &&
                  data["FullName"].toString() ==
                      myController1.text.toString() &&
                  data["Sicil"].toString() == myController2.text.toString()) {
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
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBar(),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBar(),
              );
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
}
