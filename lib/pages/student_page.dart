// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../widgets/arrow_back.dart';
import '../widgets/back_buttons.dart';
import '../widgets/scan_qr.dart';
import '../widgets/user_info.dart';

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

  Future<bool> _onBackPressed() async {
    return await BackFunctions.onBackPressed(context);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Tarih ve saat bilgisini biçimlendir
    String formattedDate = "${now.day}/${now.month}/${now.year}";
    String formattedTime = "${now.hour}:${now.minute}:${now.second}";

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: arrowBack(context, widget.data1, widget.data2, null),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              userInfo(widget.data1, widget.data2),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QRViewExample(
                        fullName: widget.data1!.text.toString(),
                        sicil: widget.data2!.text.toString(),
                        date: formattedDate,
                        time: formattedTime,
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 100.sp,
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        "assets/pngwing.com.png",
                        width: 150.sp,
                        height: 150.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Constants.sanofiBig(),
            ],
          ),
        ),
      ),
    );
  }
}
