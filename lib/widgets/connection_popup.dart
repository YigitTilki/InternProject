import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'alert_dialog.dart';

Future<void> showNoInternetDialog(context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: noNetAlert(context),
      );
    },
  );
}

void openWifiSettings() async {
  const platform = MethodChannel('your_channel_name');

  try {
    await platform.invokeMethod('openWifiSettings');
  } on PlatformException catch (e) {
    debugPrint('Hata: $e');
  }
}
