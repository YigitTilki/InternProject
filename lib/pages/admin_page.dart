import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/adminstator_process.dart/add_lesson.dart';
import 'package:sanofi_main/adminstator_process.dart/add_participant.dart';
import 'package:sanofi_main/adminstator_process.dart/add_teacher.dart';
import 'package:sanofi_main/constants/constants.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white, // Popup arka plan rengi
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Şekil ayarı
            ),
            title: Text(
              "Uygulamadan çıkmak istiyor musunuz?",
              style: Constants.getTextStyle(Colors.black, 20.0),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.purple, // İstenilen renge ayarlayabilirsiniz
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Diğer stil ayarları
                ),
                child: Text(
                  "Hayır",
                  style: Constants.getTextStyle(Colors.white, 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    SystemNavigator.pop(); // Uygulamadan çık
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.purple, // İstenilen renge ayarlayabilirsiniz
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Diğer stil ayarları
                  ),
                  child: Text(
                    "Evet",
                    style: Constants.getTextStyle(Colors.white, 14.0),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(127, 80, 127, 100),
                  child: Image.asset(
                    "assets/adminicon.png",
                    height: 95,
                    width: 95,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  participantAdd(context),
                  lessonAdd(context),
                ],
              ),
              const SizedBox(
                height: 21,
              ),
              teacherAdd(context),
              Expanded(flex: 1, child: Constants.sanofiBig())
            ],
          ),
        ),
      ),
    );
  }
}
