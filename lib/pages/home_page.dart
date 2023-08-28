import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sanofi_main/pages/login_page_s.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPageS()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 170.sp,
          width: 150.sp,
          child: Image.asset("assets/SNY.png"),
        ),
      ),
    );
  }
}
