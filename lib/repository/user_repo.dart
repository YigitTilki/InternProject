import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String? id;
  final String fullName;
  final String sicil;

  const AddUser(
      {super.key, this.id, required this.fullName, required this.sicil});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    Future<void> addUser() {
      return users.doc(sicil).set({"FullName": fullName, "Sicil": sicil});
    }

    return TextButton(
      onPressed: addUser,
      child: const Text(
        "Add User",
      ),
    );
  }
}
