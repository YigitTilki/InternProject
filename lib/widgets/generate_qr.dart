import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

generateQR(String data) {
  return Expanded(
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
  );
}
