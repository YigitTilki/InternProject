import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class Constants {
  Constants._();
  static TextStyle getTextStyle(color, size) {
    return TextStyle(
        color: color,
        fontFamily: "JosefinSans",
        fontSize: size,
        decoration: TextDecoration.none);
  }

  static Padding sanofiBig() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.sp, bottom: 8.sp),
      child: SizedBox(
        height: 50.sp,
        width: 250.sp,
        child: Image.asset("assets/SNY_BIG.png"),
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
