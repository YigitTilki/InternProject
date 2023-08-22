import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/pages/login_page_t.dart';
import 'package:sanofi_main/pages/student_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          children: [
            const Expanded(
              child: SizedBox(
                height: 119,
              ),
            ),
            Constants.sanofiBig(),
            Text(
              "Eğitim Yoklama Sistemi",
              style: Constants.getTextStyle(Colors.black, 15.0),
            ),
            const Expanded(
              child: SizedBox(
                height: 227,
              ),
            ),
            textFormFieldProcess("Ad-Soyad", myController1),
            const SizedBox(
              height: 35,
            ),
            textFormFieldProcess("Sicil No", myController2),
            const SizedBox(
              height: 30,
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
              height: 10,
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
            const Expanded(
              child: SizedBox(
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
