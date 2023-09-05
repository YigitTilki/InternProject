// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/widgets/connection_popup.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';
import '../widgets/arrow_back.dart';
import '../widgets/back_buttons.dart';
import '../widgets/generate_qr.dart';
import '../widgets/user_info.dart';

// ignore: must_be_immutable
class TeacherPage extends StatefulWidget {
  TeacherPage({super.key, this.data1, this.data2, this.data3, this.data4});
  TextEditingController? data1 = TextEditingController();
  TextEditingController? data2 = TextEditingController();
  TextEditingController? data3 = TextEditingController();
  String? data4;

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
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

  Future<bool> _onBackPressed() async {
    return await BackFunctions.onBackPressed(context);
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final docref = db.collection(widget.data4.toString());
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: teacherandstudent_bg,
        appBar: arrowBack(context, widget.data1, widget.data2, widget.data3),
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: userInfo(widget.data1, widget.data2),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100.sp,
              ),
            ),
            Text(
              "${widget.data4 ?? ""}${'icin-qr-kod'.tr}",
              style: Constants.getTextStyle(Colors.black, 20.0.sp),
            ),
            generateQR(widget.data4 ?? "", docref, context),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 70.sp,
              ),
            ),
            Constants.sanofiBig(),
            SizedBox(
              height: 100.sp,
            )
          ],
        ),
      ),
    );
  }
}
