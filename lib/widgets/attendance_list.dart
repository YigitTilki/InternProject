// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanofi_main/constants/constants.dart';

class AttendanceListBuilder extends StatefulWidget {
  const AttendanceListBuilder({super.key, required this.collectionReference});
  final CollectionReference collectionReference;

  @override
  State<AttendanceListBuilder> createState() => _AttendanceListBuilderState();
}

class _AttendanceListBuilderState extends State<AttendanceListBuilder> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];

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
                return fullName.contains(query);
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
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => _search(), icon: const Icon(Icons.search)),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                "assets/SNY.png",
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 10,
              )
            ],
            elevation: 0,
            title: const Text("Katılımcılar"),
            backgroundColor: Colors.purpleAccent.shade100,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Arama yapın...',
                  ),
                  onChanged: (value) => _search(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = searchResults[index];
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 6.0),
                      tileColor: Colors.purple.withOpacity(0.8),
                      leading: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(Icons.person),
                      ),
                      title: Text(
                        data['FullName'],
                        style: Constants.getTextStyle(Colors.white, 22.0),
                      ),
                      subtitle: Text(
                        data['Sicil'],
                        style:
                            Constants.getTextStyle(Colors.grey.shade300, 14.0),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            data['Tarih'],
                            style: Constants.getTextStyle(Colors.white, 14.0),
                          ),
                          Text(
                            data['Saat'],
                            style: Constants.getTextStyle(Colors.white, 14.0),
                          ),
                        ],
                      ),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
