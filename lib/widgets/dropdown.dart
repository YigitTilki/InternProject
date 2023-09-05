import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sizer/sizer.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    Key? key,
    required this.selectedLesson,
    required this.onSelectionChanged,
  }) : super(key: key);

  final String? selectedLesson;
  final void Function(String?) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getLessonList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        }

        List<String> lessonList = snapshot.data ?? [];

        return Padding(
          padding: EdgeInsets.only(left: 25.0.sp, right: 25.0.sp),
          child: DropdownSearch<String>(
            popupProps: PopupProps.dialog(
              scrollbarProps: ScrollbarProps(
                thumbColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
              searchFieldProps: TextFieldProps(
                padding: EdgeInsets.fromLTRB(13.sp, 20.sp, 13.sp, 10.sp),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                ),
                style: Constants.getTextStyle(Colors.black, 14.0.sp),
              ),
              listViewProps: ListViewProps(
                padding: EdgeInsets.all(5.sp),
              ),
              dialogProps: DialogProps(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.sp),
                ),
              ),
              showSelectedItems: true,
              showSearchBox: true,
            ),
            items: lessonList,
            onChanged: (String? newValue) {
              onSelectionChanged(newValue);
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "ders-seciniz".tr,
                labelStyle: Constants.getTextStyle(Colors.grey, 11.0.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.sp),
                ),
              ),
            ),
            selectedItem: selectedLesson,
            validator: (String? item) {
              if (item == null || item.isEmpty) {
                return 'Ders seçmek zorunludur.';
              }
              return null;
            },
          ),
        );
      },
    );
  }

  Future<List<String>> getLessonList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Dersler').get();
    List<String> lessonList = querySnapshot.docs.map((doc) {
      var lessonData = doc.data() as Map<String, dynamic>;
      return "${lessonData["Ders"]}";
    }).toList();
    return lessonList;
  }
}
