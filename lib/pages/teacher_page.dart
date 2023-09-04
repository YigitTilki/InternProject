// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sanofi_main/widgets/connection_popup.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../widgets/arrow_back.dart';
import '../widgets/attendance_list.dart';
import '../widgets/back_buttons.dart';
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
  bool hasInternet = true; // Başlangıçta internetin olduğunu varsayalım
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
        // İnternet bağlantısı yoksa hasInternet'i false olarak ayarla
        setState(() {
          hasInternet = false;
        });
        // İnternet bağlantısı kesildiğinde popup göster
        showNoInternetDialog(context);
      } else {
        // İnternet bağlantısı varsa hasInternet'i true olarak ayarla
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
        backgroundColor: const Color.fromARGB(255, 246, 198, 255),
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

generateQR(String data, CollectionReference collectionReference, context) {
  return GestureDetector(
    onLongPress: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AttendanceListBuilder(
                collectionReference: collectionReference,
                colStr: data,
              )));
    },
    child: Expanded(
      child: SizedBox(
        height: 250,
        width: 250,
        child: Center(
          child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 250,
          ),
        ),
      ),
    ),
  );
}
