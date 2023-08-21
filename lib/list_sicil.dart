// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:sanofi_main/scan_qr.dart';

// ignore: must_be_immutable
class ListSicil extends StatefulWidget {
  ListSicil({
    super.key,
  });
  Map<String, dynamic>? data;
  @override
  State<ListSicil> createState() => _ListSicilState();
}

class _ListSicilState extends State<ListSicil> {
  List<DocumentSnapshot> documents = [];

  Future<void> loadAttendanceData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

    setState(() {
      documents = querySnapshot.docs;
    });

    int index = 0;
    if (index >= 0 && index < documents.length) {
      widget.data = documents[index].data() as Map<String, dynamic>;

      print(widget.data!['fieldName']);
    }
  }

  @override
  void initState() {
    super.initState();
    loadAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

  /*List<DocumentSnapshot> documents = []; 

  @override
  void initState() {
    super.initState();
    loadAttendanceData();
  }

  Future<void> loadAttendanceData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('your_collection_name').get();

    setState(() {
      documents = querySnapshot.docs; 
    });

    
    int index = 0; 
    if (index >= 0 && index < documents.length) {
      var data = documents[index].data() as Map<String, dynamic>;
     
      print(data['fieldName']);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    throw UnimplementedError();
  }*/

  
