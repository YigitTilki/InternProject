import 'package:flutter/material.dart';
import 'package:sanofi_main/scan_qr.dart';

class QrScanTeacher extends StatelessWidget {
  const QrScanTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Eğitimin Adı",
              style: TextStyle(fontSize: 36),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRViewExample()));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    size: 140,
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "assets/pngwing.com.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/SNY_BIG.png",
              width: 278,
              height: 61,
            ),
          ],
        ),
      ),
    );
  }
}
