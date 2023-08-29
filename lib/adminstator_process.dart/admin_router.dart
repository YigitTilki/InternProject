import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../pages/admin_page.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_form_field.dart';

Future<dynamic> adminRouter(
    BuildContext context, TextEditingController controller) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      FieldUtils.clearFields(controller1: controller);
      return alertDialogProcess(
        null,
        const Icon(Icons.lock_outlined),
        SizedBox(
          width: 400.sp,
          child: textFormFieldProcess("Admin Password", controller, null),
        ),
        [
          elevatedButtonProcess(
            Text(
              "Giriş",
              style: Constants.getTextStyle(Colors.white, 12.0.sp),
            ),
            () {
              if (controller.text.toString() == sifre) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminPage(),
                  ),
                );
              } else {
                FieldUtils.clearFields(controller1: controller);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(
                        "Şifre Hatalı",
                        textAlign: TextAlign.center,
                        style: Constants.getTextStyle(Colors.red, 48.0.sp),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      );
    },
  );
}
