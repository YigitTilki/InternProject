import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

generateQR() {
  return Expanded(
    child: SizedBox(
      height: 250,
      width: 250,
      child: Center(
        child: QrImageView(
          data: "selam",
          version: QrVersions.auto,
          size: 250,
        ),
      ),
    ),
  );
}
