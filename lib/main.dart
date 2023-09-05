// ignore_for_file: prefer_if_null_operators

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:sanofi_main/pages/home_page.dart';

import 'package:flutter/material.dart';

import 'db_helper.dart/firebase_options.dart';
import 'package:sizer/sizer.dart';

import 'widgets/translater.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Dil(),
        locale: Get.locale == null ? Get.deviceLocale : Get.locale,
        fallbackLocale: Dil.varsayilan,
        home: const HomePage(),
      );
    });
  }
}
