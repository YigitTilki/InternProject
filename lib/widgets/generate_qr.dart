import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'attendance_list.dart';

generateQR(String data, CollectionReference collectionReference, context) {
  return GestureDetector(
    onLongPress: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AttendanceListBuilder(
                collectionReference: collectionReference,
                colStr: data,
              )));
    },
    child: Expanded(
      child: SizedBox(
        height: 250,
        width: 250,
        child: Center(
          child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 250,
          ),
        ),
      ),
    ),
  );
}
