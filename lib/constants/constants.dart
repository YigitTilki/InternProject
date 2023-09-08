// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/theme_provider.dart';

class Constants {
  Constants._();
  static TextStyle getTextStyle(color, size) {
    return TextStyle(
        color: color,
        fontFamily: "JosefinSans",
        fontSize: size,
        decoration: TextDecoration.none);
  }

  static Padding snyBIG(context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    // Tema moduna göre farklı bir resim dosya adını belirleyin
    final assetName =
        isDarkMode ? "assets/light_SNY_BIG.png" : "assets/SNY_BIG.png";
    return Padding(
      padding: EdgeInsets.only(top: 16.0.sp, bottom: 8.sp),
      child: SizedBox(
        height: 50.sp,
        width: 250.sp,
        child: Image.asset(assetName),
      ),
    );
  }
}

class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class FieldUtils {
  static void clearFields({
    TextEditingController? controller1,
    TextEditingController? controller2,
    TextEditingController? controller3,
  }) {
    controller1?.clear();
    controller2?.clear();
    controller3?.clear();
  }
}

String sifre = "sifre";
FilteringTextInputFormatter nameFormatter = FilteringTextInputFormatter.deny(
  RegExp(
      r'[+/\=!@#%^&*(),.?":{}|<>üÜğ$\-+/;Ğİı~`•√π÷×¶∆£¢€¥°=\\©®™✓\[\]ŞşÇçöÖ0123456789]'),
);

FilteringTextInputFormatter sicilFormatter = FilteringTextInputFormatter.deny(
  RegExp(
      r'[+/\=!@#%^&*(),.?":{}|<>üÜğ$\-+/;Ğİı~`•√π÷×¶∆£¢€¥°=\\©®™✓\[\]ŞşÇçöÖ]'),
);

bool hasInternet = true;

DateTime now = DateTime.now();

String formattedDate = "${now.day}/${now.month}/${now.year}";
String formattedTime = "${now.hour}:${now.minute}:${now.second}";

Color showDeveloperNamesDialog_bgcolor =
    const Color.fromARGB(255, 231, 96, 255);
Color main1 = Colors.black;
Color main2 = Colors.white;
Color hp_Connectiondialog_bg = const Color.fromARGB(255, 172, 69, 190);
Color teacherandstudent_bg = const Color.fromARGB(255, 246, 198, 255);
Color main3 = Colors.purple;
Color ListTileColor = Colors.purple.withOpacity(0.8);
Color subTitleSicil = Colors.grey.shade300;
Color katilimcilarBg = Colors.purpleAccent.shade100;
Color ConnectionPopupBg = const Color.fromARGB(255, 172, 69, 190);
Color adminPageContainerDesignDec = const Color(0xCC7B00EB);
Color areYouSureContainerDec = Colors.black.withOpacity(0.8);
Color main4 = Colors.red;
Color main5 = Colors.grey;
Color main6 = Colors.green;
Color QRViewBorderColor = const Color.fromARGB(255, 239, 183, 249);
Color userInfoColor = const Color.fromRGBO(83, 42, 155, 1);
