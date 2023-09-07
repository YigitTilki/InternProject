import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      // ignore: deprecated_member_use
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 88, 0, 99),
      primaryColor: const Color.fromARGB(255, 187, 38, 38),
      dividerColor: Colors.purple,
      hintColor: Colors.white,
      colorScheme:
          const ColorScheme.dark(primary: Color.fromRGBO(138, 33, 231, 1)),
      highlightColor: Colors.black);

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    highlightColor: Colors.purple,
    hintColor: Colors.black,
    dividerColor: const Color.fromARGB(255, 246, 198, 255),
    primaryColor: Colors.white,
    colorScheme:
        const ColorScheme.light(primary: Color.fromRGBO(83, 42, 155, 1)),
  );
}
