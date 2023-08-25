// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> add(BuildContext context, CollectionReference collectionReference,
    TextEditingController controller, Map<String, dynamic> data) async {
  try {
    await collectionReference.doc(controller.text.toString()).set(data);

    Navigator.pop(context);
  } catch (error) {
    debugPrint("Hata oluştu: $error");
  }
}

Future<void> delete(
    BuildContext context,
    CollectionReference collectionReference,
    TextEditingController controller) async {
  try {
    await collectionReference.doc(controller.text.toString()).delete();

    Navigator.pop(context);
  } catch (error) {
    debugPrint("Hata oluştu: $error");
  }
}

Future<void> update(
    BuildContext context,
    CollectionReference collectionReference,
    TextEditingController controller,
    Map<String, dynamic> data) {
  return collectionReference
      .doc(controller.text.toString())
      .update(data)
      .then((value) => debugPrint("Updated"))
      .catchError((error) => debugPrint("Failed to update : $error"));
}
