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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ), // Geri simgesi
            onPressed: () {
              Navigator.of(context).pop(); // Bir önceki sayfaya dön
            },
          ),
        ),
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
      ),
    );
  }
}
