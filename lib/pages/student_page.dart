import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/generate_qr.dart';

// ignore: must_be_immutable
class StudentPage extends StatefulWidget {
  StudentPage({super.key, this.data1, this.data2});
  TextEditingController? data1 = TextEditingController();
  TextEditingController? data2 = TextEditingController();

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
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
          // Inside the StudentPage's build method
          generateQR('${widget.data1?.text ?? ""} ${widget.data2?.text ?? ""}'),

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
                style: const TextStyle(fontSize: 36, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              widget.data2?.text.toString() ?? "",
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
