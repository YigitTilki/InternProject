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

  Future<bool> _onBackPressedFromAppBar() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              "Bir önceki sayfaya dönmek istiyor musunuz?",
              style: Constants.getTextStyle(Colors.black, 20.0),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Hayır",
                  style: Constants.getTextStyle(Colors.white, 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
        appBar: AppBar(
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
            ), // Geri simgesi
            onPressed: () {
              _onBackPressedFromAppBar(); // Doğru fonksiyonu burada çağırın
            },
          ),
        ),
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
            Constants.sanofiBig(),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container student_p_purple_container() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  widget.data1?.text.toString() ?? "",
                  style: Constants.getTextStyle(Colors.black, 36.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              widget.data2?.text.toString() ?? "",
              style: Constants.getTextStyle(
                  const Color.fromRGBO(83, 42, 155, 1), 36.0),
            ),
          ),
        ],
      ),
    );
  }
}
