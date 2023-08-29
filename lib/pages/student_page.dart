// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../widgets/back_buttons.dart';
import '../widgets/scan_qr.dart';

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

  Future<bool> _onBackPressedFromAppBar() async {
    return await BackFunctions.onBackPressedFromAppBar(context);
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
        appBar: arrowBack(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    widget.data1?.text.toString() ?? "",
                    style: Constants.getTextStyle(Colors.black, 36.0.sp),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Text(
                    widget.data2?.text.toString() ?? "",
                    style: Constants.getTextStyle(
                        const Color.fromRGBO(83, 42, 155, 1), 36.0.sp),
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

  AppBar arrowBack() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Padding(
          padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 40,
          ),
        ),
        onPressed: () {
          FieldUtils.clearFields(
              controller1: widget.data1, controller2: widget.data2);
          _onBackPressedFromAppBar();
        },
      ),
    );
  }
}
