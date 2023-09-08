// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_null_comparison, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import '../adminstator_process.dart/admin_pop_up.dart/widgets/are_you_sure.dart';
import '../constants/constants.dart';
import '../provider/theme_provider.dart';
import 'alert_dialog.dart';
import 'elevated_button.dart';
import 'error_alert.dart';
import 'export_excel.dart';
import 'scaffold_messanger.dart';
import 'text_form_field.dart';

class AdminAttendanceListBuilder extends StatefulWidget {
  const AdminAttendanceListBuilder({
    super.key,
    required this.collectionReference,
    required this.colStr,
  });
  final CollectionReference collectionReference;
  final String colStr;

  @override
  State<AdminAttendanceListBuilder> createState() =>
      _AdminAttendanceListBuilderState();
}

class _AdminAttendanceListBuilderState
    extends State<AdminAttendanceListBuilder> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.collectionReference.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        void _search() {
          String query = _searchController.text.toLowerCase();

          if (query.isNotEmpty) {
            setState(() {
              searchResults = snapshot.data!.docs.where((document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String fullName = data['FullName'].toLowerCase();
                String sicil = data['Sicil'].toLowerCase();
                return fullName.contains(query) || sicil.contains(query);
              }).toList();
            });
          } else {
            setState(() {
              searchResults = snapshot.data!.docs;
            });
          }
        }

        return Scaffold(
          backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          appBar:
              attendanceAppBar(context, formattedDate, formattedTime, _search),
          body: Column(
            children: [
              Container(
                color: Theme.of(Get.context!).scaffoldBackgroundColor,
                height: 40.sp,
                width: double.infinity,
                child: searchProcess(_search),
              ),
              Expanded(
                child: listView(),
              ),
            ],
          ),
        );
      },
    );
  }

  TextField searchProcess(void Function() _search) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'arama-yap'.tr,
        hintStyle:
            Constants.getTextStyle(Theme.of(Get.context!).hintColor, 13.sp),
        prefixIcon: IconButton(
          onPressed: () {
            return _search();
          },
          icon: Icon(
            Icons.search,
            color: Theme.of(Get.context!).hintColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(Get.context!).dividerColor),
        ),
        filled: true,
        fillColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      ),
      onChanged: (value) => _search(),
    );
  }

  ListView listView() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        DocumentSnapshot document = searchResults[index];
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        return ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 6.0.sp),
          tileColor: Theme.of(Get.context!).dividerColor.withOpacity(0.8),
          leading: Padding(
            padding: EdgeInsets.only(top: 6.0.sp),
            child: const Icon(Icons.person),
          ),
          title: Text(
            data['FullName'],
            style: Constants.getTextStyle(
                Theme.of(Get.context!).hintColor, 16.0.sp),
          ),
          subtitle: Text(
            data['Sicil'],
            style: Constants.getTextStyle(
                Theme.of(Get.context!).hintColor, 12.0.sp),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                data['Tarih'],
                style: Constants.getTextStyle(
                    Theme.of(Get.context!).hintColor, 12.0.sp),
              ),
              Text(
                data['Saat'],
                style: Constants.getTextStyle(
                    Theme.of(Get.context!).hintColor, 12.0.sp),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.3.sp,
              color: Theme.of(Get.context!).hintColor,
            ),
          ),
        );
      },
    );
  }

  AppBar attendanceAppBar(BuildContext context, String formattedDate,
      String formattedTime, void Function() _search) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // ThemeProvider'ı alın
    final isDarkMode = themeProvider.isDarkMode; // Tema modunu alın
    return AppBar(
      actions: [
        PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Theme.of(Get.context!).dividerColor,
          icon: Image.asset(
            isDarkMode ? 'assets/light_SNY.png' : 'assets/SNY.png',
            height: 20.sp,
            width: 20.sp,
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    const Icon(Icons.download),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Download",
                      style: Constants.getTextStyle(
                          Theme.of(Get.context!).hintColor, 11.sp),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(Get.context!).hintColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add",
                      style: Constants.getTextStyle(
                          Theme.of(Get.context!).hintColor, 11.sp),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Theme.of(Get.context!).hintColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Delete",
                      style: Constants.getTextStyle(
                          Theme.of(Get.context!).hintColor, 11.sp),
                    ),
                  ],
                ),
              ),
            ];
          },
          onSelected: (value) async {
            if (value == 0) {
              _search();
              exportDataToCSV(searchResults, context, widget.colStr);
            } else if (value == 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    FieldUtils.clearFields(
                        controller1: myController1, controller2: myController2);
                    return addAttendance(context, formattedDate, formattedTime);
                  });
            } else if (value == 2) {
              QuerySnapshot querySnapshot =
                  await widget.collectionReference.get();
              for (QueryDocumentSnapshot documentSnapshot
                  in querySnapshot.docs) {
                await documentSnapshot.reference.delete();
              }
            }
          },
        ),
        SizedBox(
          width: 10.sp,
        )
      ],
      elevation: 0,
      title: Text(
        'katilimcilar'.tr,
        style: Constants.getTextStyle(Theme.of(Get.context!).hintColor, 18.sp),
      ),
      backgroundColor: Theme.of(Get.context!).dividerColor,
    );
  }

  AlertDialog addAttendance(
      BuildContext context, String formattedDate, String formattedTime) {
    return alertDialogProcess(
      Text(
        'katilimci-ekle'.tr,
        textAlign: TextAlign.center,
        style:
            Constants.getTextStyle(Theme.of(Get.context!).hintColor, 20.0.sp),
      ),
      null,
      SizedBox(
        width: 500.sp,
        height: 115.sp,
        child: Column(
          children: [
            Expanded(
              child: textFormFieldProcess('ad-soyad'.tr, myController1,
                  [UppercaseInputFormatter(), nameFormatter]),
            ),
            Expanded(
              child: textFormFieldProcess(
                  'sicil'.tr, myController2, [sicilFormatter]),
            ),
          ],
        ),
      ),
      [
        elevatedButtonProcess(
          Text(
            'ekle'.tr,
            style: Constants.getTextStyle(
                Theme.of(Get.context!).hintColor, 11.0.sp),
          ),
          () {
            Navigator.pop(context);
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return areYouSure(context, formattedDate, formattedTime);
              },
            );
          },
        ),
        backElevatedButton(context, 'geri-don'.tr),
      ],
    );
  }

  Padding areYouSure(
      BuildContext context, String formattedDate, String formattedTime) {
    return areYouSureUser(
      "${'ad-soyad:'.tr}${myController1.text.toString()}",
      "${'sicil:'.tr}${myController2.text.toString()}",
      "",
      widget.collectionReference,
      context,
      null,
      elevatedButtonProcess(
        Text(
          'onay'.tr,
          style:
              Constants.getTextStyle(Theme.of(Get.context!).hintColor, 11.0.sp),
        ),
        () async {
          final sicilNo = myController2.text.toString();
          final adSoyad = myController1.text.toString();

          if (sicilNo.isNotEmpty && adSoyad.isNotEmpty) {
            final docRef = widget.collectionReference.doc(sicilNo);

            try {
              final doc = await docRef.get();
              if (doc.exists) {
                final data = doc.data() as Map<String, dynamic>;

                if (data != null && data["Sicil"].toString() == sicilNo) {
                  Navigator.pop(context);

                  return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return errorAlertDialog('boyle-katilimci-var'.tr);
                    },
                  );
                }
              } else if (adSoyad == null) {
              } else {
                await widget.collectionReference
                    .doc(myController2.text.toString())
                    .set({
                  "FullName": myController1.text.toString(),
                  "Sicil": myController2.text.toString(),
                  "Tarih": formattedDate,
                  "Saat": formattedTime
                });
                Navigator.pop(context);
              }
            } catch (e) {
              debugPrint("Error: $e");
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(),
            );
          }
        },
      ),
    );
  }
}
