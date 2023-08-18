import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/pages/qr_scan_teacher.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 139,
                    width: 320,
                    decoration: const BoxDecoration(
                      color: Color(0xff8432C5),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(44),
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "İbrahim Çerkezoğlu",
                              style:
                                  TextStyle(fontSize: 36, color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            "15664",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QrScanTeacher()));
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 50,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
