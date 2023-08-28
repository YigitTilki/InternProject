// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/pages/login_page_s.dart';

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
    bool shouldNavigate = await BackFunctions.onBackPressedFromAppBar(context);

    if (shouldNavigate) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPageS()),
      );
    }

    return shouldNavigate;
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
                        date: formattedDate,
                        time: formattedTime,
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
}
