import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../scan_qr.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  widget.data1?.text.toString() ?? "",
                  style: Constants.getTextStyle(Colors.black, 36.0),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.data2?.text.toString() ?? "",
                  style: Constants.getTextStyle(
                      const Color.fromRGBO(83, 42, 155, 1), 36.0),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QRViewExample(
                      fullName: widget.data1!.text.toString(),
                      sicil: widget.data2!.text.toString(),
                    ),
                  ),
                );
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
            Constants.sanofiBig(),
          ],
        ),
      ),
    );
  }
}
