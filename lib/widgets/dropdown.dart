import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DropDown extends StatefulWidget {
  const DropDown(
      {super.key,
      required this.selectedLesson,
      required this.onSelectionChanged});
  final String? selectedLesson;
  final void Function(String?) onSelectionChanged;
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  CollectionReference lessons =
      FirebaseFirestore.instance.collection('Dersler');
  List<String> lessonList = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: lessons.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Bir hata oluştu: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Veriler yükleniyor...');
        }

        List<DocumentSnapshot> documents = snapshot.data!.docs;

        lessonList = documents.map((doc) {
          var lessonData = doc.data() as Map<String, dynamic>;
          return "${lessonData["Ders"]}";
        }).toList();

        return DropdownButton<String>(
          hint: Text(
            "Ders Seçiniz",
            style: Constants.getTextStyle(Colors.grey, 14.0),
          ),
          value: widget.selectedLesson,
          items: lessonList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: Constants.getTextStyle(Colors.black, 14.0),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            widget.onSelectionChanged(newValue);
          },
        );
      },
    );
  }
}
