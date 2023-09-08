// ignore_for_file: prefer_if_null_operators

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'db_helper.dart/firebase_options.dart';

import 'package:sizer/sizer.dart';

import 'pages/home_page.dart';
import 'provider/theme_provider.dart';
import 'widgets/translater.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      final themeProvider = Provider.of<ThemeProvider>(context);

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme:
            themeProvider.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        translations: Dil(),
        locale: Get.locale == null ? Get.deviceLocale : Get.locale,
        fallbackLocale: Dil.varsayilan,
        home: const HomePage(),
      );
    });
  }
}
