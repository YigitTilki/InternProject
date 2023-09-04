// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_null_comparison, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sanofi_main/widgets/alert_dialog.dart';
import 'package:sanofi_main/widgets/scaffold_messanger.dart';
import 'package:sanofi_main/widgets/text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../adminstator_process.dart/admin_pop_up.dart/are_you_sure.dart';

import 'elevated_button.dart';
import 'error_alert.dart';

class AttendanceListBuilder extends StatefulWidget {
  const AttendanceListBuilder(
      {super.key, required this.collectionReference, required this.colStr});
  final CollectionReference collectionReference;
  final String colStr;

  @override
  State<AttendanceListBuilder> createState() => _AttendanceListBuilderState();
}

class _AttendanceListBuilderState extends State<AttendanceListBuilder> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();

  Future<void> saveCSVToFile(List<Map<String, dynamic>> data) async {
    List<List<dynamic>> rows = [];

    // CSV başlıkları
    rows.add(["FullName", "Sicil", "Tarih", "Saat"]);

    // Verileri ekleyin
    for (var item in data) {
      rows.add([item['FullName'], item['Sicil'], item['Tarih'], item['Saat']]);
    }

    try {
      // Uygulamanın dahili depolama dizini
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/${widget.colStr}.csv';
      final file = File(filePath);
      if (!(await file.parent.exists())) {
        await file.parent.create(recursive: true);
      }
      // CSV dosyasını oluşturun ve verileri yazın
      String csv = const ListToCsvConverter().convert(rows);
      await file.writeAsString(csv);
      await OpenFile.open(filePath);

      // Başarı mesajı
      debugPrint('CSV dosyası kaydedildi: $filePath');

      // Dosya kaydedildikten sonra kullanıcıya geri bildirim verin
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CSV dosyası dahili depolama alanına kaydedildi.'),
        ),
      );
    } catch (e) {
      debugPrint('Hata oluştu: $e');
      // Hata durumunda kullanıcıya bir hata mesajı gösterebilirsiniz.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CSV dosyası kaydedilirken bir hata oluştu.'),
        ),
      );
    }
  }

  void exportDataToCSV() {
    List<Map<String, dynamic>> data = [];

    for (var document in searchResults) {
      Map<String, dynamic> itemData = document.data() as Map<String, dynamic>;
      data.add({
        'FullName': itemData['FullName'],
        'Sicil': itemData['Sicil'],
        'Tarih': itemData['Tarih'],
        'Saat': itemData['Saat'],
      });
    }

    // Verileri CSV'ye dönüştürüp kaydetme işlemi
    saveCSVToFile(data);
  }

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
        hintText: 'arama-yap'.tr,
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
        IconButton(
          onPressed: () async {
            _search();
            exportDataToCSV();
            QuerySnapshot querySnapshot =
                await widget.collectionReference.get();
            for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
              await documentSnapshot.reference.delete();
            }
          },
          icon: const Icon(Icons.download),
        ),
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
      title: Text('katilimcilar'.tr),
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
                    'katilimci-ekle'.tr,
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
                                'ad-soyad'.tr,
                                myController1,
                                [UppercaseInputFormatter(), nameFormatter]),
                          ),
                          Expanded(
                            flex: 2,
                            child: textFormFieldProcess(
                                'sicil'.tr, myController2, [sicilFormatter]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  [
                    Expanded(
                      child: elevatedButtonProcess(
                        Text(
                          'ekle'.tr,
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
                      child: backElevatedButton(context, 'geri-don'.tr),
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
      "${'ad-soyad:'.tr}${myController1.text.toString()}",
      "${'sicil:'.tr}${myController2.text.toString()}",
      "",
      widget.collectionReference,
      context,
      null,
      elevatedButtonProcess(
        Text(
          'onay'.tr,
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
