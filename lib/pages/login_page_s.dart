import 'package:flutter/material.dart';
import 'package:sanofi_main/pages/login_page_t.dart';

import 'package:sanofi_main/widgets/text_form_field.dart';

import '../widgets/sign_in_button.dart';

class LoginPageS extends StatelessWidget {
  LoginPageS({super.key});

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
            textFormFieldProcess("Ad-Soyad", myController1),
            const SizedBox(
              height: 35,
            ),
            textFormFieldProcess("Sicil No", myController2),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: signInMethod(context),
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
