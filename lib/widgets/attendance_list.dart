import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceListBuilder extends StatefulWidget {
  const AttendanceListBuilder({super.key, required this.collectionReference});
  final CollectionReference collectionReference;

  @override
  State<AttendanceListBuilder> createState() => _AttendanceListBuilderState();
}

class _AttendanceListBuilderState extends State<AttendanceListBuilder> {
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

        // Firestore'dan gelen dökümanları ListView içinde listele
        return Scaffold(
          appBar: AppBar(title: Text("Katılımcılar")),
          body: ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              // Her bir dökümanı ListTile içinde göster
              return ListTile(
                title: Text(data['FullName']),
                subtitle: Text(data['Sicil']),
                trailing: Text(data['Saat']),
                leading: Text(data["Tarih"]),
                // Diğer verileri burada da gösterebilirsiniz
              );
            },
          ),
        );
      },
    );
  }
}
