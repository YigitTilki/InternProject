// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../widgets/attendance_list.dart';
import '../widgets/back_buttons.dart';
import 'login_page_t.dart';

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
  }

  Future<bool> _onBackPressed() async {
    return await BackFunctions.onBackPressed(context);
  }

  Future<bool> _onBackPressedFromAppBar() async {
    bool shouldNavigate = await BackFunctions.onBackPressedFromAppBar(context);

    if (shouldNavigate) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPageT()),
      );
    }

    return shouldNavigate;
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final docref = db.collection(widget.data4.toString());
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 198, 255),
        appBar: arrowBack(),
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: userInfo(),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100.sp,
              ),
            ),
            Text(
              "${widget.data4 ?? ""} için QR kod",
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

  AppBar arrowBack() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 40,
          ),
        ),
        onPressed: () {
          _onBackPressedFromAppBar();
        },
      ),
    );
  }

  Column userInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0.sp),
            child: Padding(
              padding: EdgeInsets.only(top: 25.sp),
              child: Text(
                widget.data1?.text.toString() ?? "",
                style: Constants.getTextStyle(Colors.black, 36.0.sp),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0.sp),
          child: Text(
            widget.data2?.text.toString() ?? "",
            style: Constants.getTextStyle(
                const Color.fromRGBO(83, 42, 155, 1), 36.0.sp),
          ),
        ),
      ],
    );
  }
}

generateQR(String data, CollectionReference collectionReference, context) {
  return GestureDetector(
    onLongPress: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AttendanceListBuilder(
                collectionReference: collectionReference,
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
