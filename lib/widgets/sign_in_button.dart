import 'package:flutter/material.dart';

import '../pages/student_page.dart';

ElevatedButton signInMethod(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentPage(),
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
  );
}
