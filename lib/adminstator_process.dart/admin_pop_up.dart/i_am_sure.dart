// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/widgets/containers.dart';

import '../../constants/constants.dart';

import '../../widgets/elevated_button.dart';

ElevatedButton iAmSureUser(
    TextEditingController myController1,
    TextEditingController myController2,
    CollectionReference<Object?> collectionReference,
    BuildContext context,
    Future<void> Function() addUser,
    Future<void> Function() updateUser) {
  return elevatedButtonProcess(
    Text(
      "Onaylıyorum",
      style: Constants.getTextStyle(Colors.white, 16.0),
    ),
    () async {
      final sicilNo = myController2.text.toString();
      final adSoyad = myController1.text.toString();

      if (sicilNo.isNotEmpty && adSoyad.isNotEmpty) {
        final docRef = collectionReference.doc(sicilNo);

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
                      const SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Böyle bir sicil mevcut ismi güncellemek ister misin?",
                            textAlign: TextAlign.center,
                            style: Constants.getTextStyle(Colors.white, 24.0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              elevatedButtonProcess(
                                const Text("Güncelle"),
                                () async {
                                  await updateUser();

                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              elevatedButtonProcess(
                                const Text("İptal"),
                                () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            await addUser();
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
  );
}
