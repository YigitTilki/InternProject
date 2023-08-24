import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanofi_main/pages/admin_page.dart';
import 'package:sanofi_main/pages/login_page_t.dart';
import 'package:sanofi_main/pages/student_page.dart';
import 'package:sanofi_main/widgets/alert_dialog.dart';
import 'package:sanofi_main/widgets/elevated_button.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';

import '../constants/constants.dart';

class LoginPageS extends StatefulWidget {
  const LoginPageS({Key? key}) : super(key: key);

  @override
  State<LoginPageS> createState() => _LoginPageSState();
}

class _LoginPageSState extends State<LoginPageS> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final passwordController = TextEditingController();

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
    String password = "sifre";
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              const Expanded(
                flex: 0,
                child: SizedBox(
                  height: 100,
                ),
              ),
              Constants.sanofiBig(),
              Text(
                "Eğitim Yoklama Sistemi",
                style: Constants.getTextStyle(Colors.black, 15.0),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50,
                ),
              ),
              textFormFieldProcess("Ad-Soyad", myController1),
              const SizedBox(
                height: 10,
              ),
              textFormFieldProcess("Sicil No", myController2),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    final sicilNo = myController2.text.toString();

                    if (sicilNo.isNotEmpty) {
                      final docRef = db.collection("Users").doc(sicilNo);

                      try {
                        final doc = await docRef.get();
                        final data = doc.data() as Map<String, dynamic>;

                        if (data["FullName"].toString() ==
                            myController1.text.toString()) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentPage(
                                data1: myController1,
                                data2: myController2,
                              ),
                            ),
                          );
                        } else {
                          debugPrint("olmadı");
                        }
                      } catch (e) {
                        // Handle errors, such as document not found
                        debugPrint("Error: $e");
                      }
                    } else {
                      // Handle the case where Sicil No is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sicil No alanını doldurun.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    minimumSize: const Size(100, 35),
                  ),
                  child: Text(
                    "Giriş",
                    style: Constants.getTextStyle(Colors.white, 16.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPageT(),
                    ),
                  );
                },
                child: Text(
                  "Eğitimci Girişi",
                  style: Constants.getTextStyle(Colors.black, 14.0),
                ),
              ),
              const SizedBox(
                height: 170,
              ),
              GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alertDialogProcess(
                        null,
                        const Icon(Icons.lock_outlined),
                        SizedBox(
                          width: 400,
                          child: textFormFieldProcess(
                              "Admin Password", passwordController),
                        ),
                        [
                          elevatedButtonProcess(
                            Text(
                              "Giriş",
                              style: Constants.getTextStyle(Colors.white, 16.0),
                            ),
                            () {
                              if (passwordController.text.toString() ==
                                  password) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const AdminPage(),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Text(
                                        "Şifre Hatalı",
                                        style: Constants.getTextStyle(
                                            Colors.red, 48.0),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Image.asset(
                  "assets/SNY.png",
                  height: 20,
                  width: 20,
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
