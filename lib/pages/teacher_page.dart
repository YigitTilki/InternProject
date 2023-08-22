import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../generate_qr.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: student_p_purple_container(),
          ),
          const SizedBox(
            height: 100,
          ),
          Text(
            "${widget.data4 ?? ""} için QR kod",
            style: Constants.getTextStyle(Colors.black, 20.0),
          ),
          // Inside the StudentPage's build method
          generateQR(widget.data4 ?? ""),

          const SizedBox(
            height: 70,
          ),
          Image.asset(
            "assets/SNY_BIG.png",
            width: 278,
            height: 61,
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container student_p_purple_container() {
    return Container(
      height: 139,
      width: 256,
      decoration: const BoxDecoration(
        color: Color(0xff8432C5),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(44),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                widget.data1?.text.toString() ?? "",
                style: Constants.getTextStyle(Colors.black, 36.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              widget.data2?.text.toString() ?? "",
              style: Constants.getTextStyle(Colors.white, 24.0),
            ),
          ),
        ],
      ),
    );
  }
}
