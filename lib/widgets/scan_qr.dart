// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sanofi_main/constants/constants.dart';
import 'package:sizer/sizer.dart';

class QRViewExample extends StatefulWidget {
  final String? fullName;
  final String? sicil;
  final String? date;
  final String? time;
  const QRViewExample({
    Key? key,
    required this.fullName,
    required this.sicil,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    String? dersVeri = result?.code;
    CollectionReference attendance =
        FirebaseFirestore.instance.collection(dersVeri.toString());

    Future<void> addUser() async {
      return await attendance.doc(widget.sicil).set({
        "FullName": widget.fullName.toString(),
        "Sicil": widget.sicil.toString(),
        "Tarih": widget.date,
        "Saat": widget.time
      });
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: result != null
                ? Center(
                    child: FutureBuilder<void>(
                      future: addUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Center(
                            child: Image.asset(
                              "assets/check-green-unscreen.gif",
                              height: 35.sp,
                              width: 35.sp,
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  )
                : Center(
                    child: Text(
                    'scan-code'.tr,
                    style: Constants.getTextStyle(Colors.black, 24.0.sp),
                  )),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400.sp ||
            MediaQuery.of(context).size.height < 400.sp)
        ? 150.0.sp
        : 300.0.sp;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color.fromARGB(255, 239, 183, 249),
          borderRadius: 10.sp,
          borderLength: 20.sp,
          borderWidth: 10.sp,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (result != null) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 0,
                backgroundColor: Colors.white,
                content: Image.asset(
                  "assets/check-green-unscreen.gif",
                  height: 35.sp,
                  width: 35.sp,
                ),
                actions: [
                  Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'yoklamaya-katildiniz'.tr,
                        style: Constants.getTextStyle(Colors.green, 15.0.sp),
                      ),
                    ),
                  ),
                ],
              );
            });
      }
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
