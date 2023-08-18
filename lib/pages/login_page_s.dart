import 'package:flutter/material.dart';
import 'package:sanofi_main/pages/login_page_t.dart';

import 'package:sanofi_main/pages/student_page.dart';

class LoginPageS extends StatefulWidget {
  const LoginPageS({super.key});

  @override
  State<LoginPageS> createState() => _LoginPageSState();
}

class _LoginPageSState extends State<LoginPageS> {
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: SizedBox(
                height: 51.56,
                width: 200,
                child: Image.asset("assets/SNY_BIG.png"),
              ),
            ),
            const Text("Eğitim Yoklama Sistemi"),
            const Expanded(
              child: SizedBox(
                height: 227,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Ad-Soyad",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Sicil No",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentPage(),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    minimumSize: const Size(100, 35)),
                child: const Text(
                  "Giriş",
                  style: TextStyle(fontSize: 16),
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
              child: const Text(
                "Eğitimci Girişi",
                style: TextStyle(color: Colors.black),
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
