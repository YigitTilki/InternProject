// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sanofi_main/widgets/alert_dialog.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../adminstator_process.dart/admin_pop_up.dart/are_you_sure.dart';

import 'containers.dart';
import 'elevated_button.dart';

class AttendanceListBuilder extends StatefulWidget {
  const AttendanceListBuilder({super.key, required this.collectionReference});
  final CollectionReference collectionReference;

  @override
  State<AttendanceListBuilder> createState() => _AttendanceListBuilderState();
}

class _AttendanceListBuilderState extends State<AttendanceListBuilder> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Tarih ve saat bilgisini biçimlendir
    String formattedDate = "${now.day}/${now.month}/${now.year}";
    String formattedTime = "${now.hour}:${now.minute}:${now.second}";
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
          backgroundColor: const Color.fromARGB(255, 246, 198, 255),
          appBar:
              attendanceAppBar(context, formattedDate, formattedTime, _search),
          body: Column(
            children: [
              Container(
                color: Colors.purple,
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
        hintText: 'Arama yapın...',
        prefixIcon: IconButton(
          onPressed: () {
            return _search();
          },
          icon: const Icon(
            Icons.search,
            color: Colors.purple,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 246, 198, 255),
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
          tileColor: Colors.purple.withOpacity(0.8),
          leading: Padding(
            padding: EdgeInsets.only(top: 6.0.sp),
            child: const Icon(Icons.person),
          ),
          title: Text(
            data['FullName'],
            style: Constants.getTextStyle(Colors.white, 16.0.sp),
          ),
          subtitle: Text(
            data['Sicil'],
            style: Constants.getTextStyle(Colors.grey.shade300, 12.0.sp),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                data['Tarih'],
                style: Constants.getTextStyle(Colors.white, 12.0.sp),
              ),
              Text(
                data['Saat'],
                style: Constants.getTextStyle(Colors.white, 12.0.sp),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.3.sp,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  AppBar attendanceAppBar(BuildContext context, String formattedDate,
      String formattedTime, void Function() _search) {
    return AppBar(
      actions: [
        addAttendance(context, formattedDate, formattedTime),
        SizedBox(
          width: 20.sp,
        ),
        Image.asset(
          "assets/SNY.png",
          height: 20.sp,
          width: 20.sp,
        ),
        SizedBox(
          width: 10.sp,
        )
      ],
      elevation: 0,
      title: const Text("Katılımcılar"),
      backgroundColor: Colors.purpleAccent.shade100,
    );
  }

  IconButton addAttendance(
      BuildContext context, String formattedDate, String formattedTime) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                FieldUtils.clearFields(
                    controller1: myController1, controller2: myController2);
                return alertDialogProcess(
                  Text(
                    "Katılımcı Ekle",
                    textAlign: TextAlign.center,
                    style: Constants.getTextStyle(Colors.black, 20.0.sp),
                  ),
                  null,
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 500.sp,
                      height: 115.sp,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: textFormFieldProcess(
                                "Ad-Soyad",
                                myController1,
                                [UppercaseInputFormatter(), nameFormatter]),
                          ),
                          Expanded(
                            flex: 2,
                            child: textFormFieldProcess(
                                "Sicil No", myController2, [sicilFormatter]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  [
                    Expanded(
                      child: elevatedButtonProcess(
                        Text(
                          "Ekle",
                          style: Constants.getTextStyle(Colors.white, 11.0.sp),
                        ),
                        () {
                          Navigator.pop(context);
                          return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return areYouSure(
                                  context, formattedDate, formattedTime);
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: backElevatedButton(context, "Geri Dön"),
                    ),
                  ],
                );
              });
        },
        icon: const Icon(Icons.add));
  }

  Padding areYouSure(
      BuildContext context, String formattedDate, String formattedTime) {
    return areYouSureUser(
      "Ad-Soyad: ${myController1.text.toString()}",
      "Sicil No: ${myController2.text.toString()}",
      "",
      widget.collectionReference,
      context,
      null,
      elevatedButtonProcess(
        Text(
          "Onaylıyorum",
          style: Constants.getTextStyle(Colors.white, 11.0.sp),
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
                      return areYouSureContainer(
                        [
                          SizedBox(
                            height: 50.sp,
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Text(
                                "Böyle bir katılımcı zaten var?",
                                textAlign: TextAlign.center,
                                style: Constants.getTextStyle(
                                    Colors.white, 24.0.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.sp,
                          ),
                        ],
                      );
                    },
                  );
                }
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
              const SnackBar(
                content: Text('Hatalı Giriş.'),
              ),
            );
          }
        },
      ),
    );
  }
}
