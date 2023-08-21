import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/pages/qr_scan_teacher.dart';

import '../scan_qr.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  widget.data1?.text.toString() ?? "",
                  style: const TextStyle(fontSize: 36),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.data4?.toString() ?? "",
                  style: const TextStyle(
                      fontSize: 36, color: Color.fromRGBO(83, 42, 155, 1)),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRViewExample()));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    size: 140,
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "assets/pngwing.com.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/SNY_BIG.png",
              width: 278,
              height: 61,
            ),
          ],
        ),
      ),
    );
  }
}
