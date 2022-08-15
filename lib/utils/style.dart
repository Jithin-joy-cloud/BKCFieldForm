import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData(bool isDark, BuildContext buildContext) {
    return ThemeData(
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
        textTheme: TextTheme(
            bodyMedium: TextStyle(
          color: isDark ? Colors.black : Colors.white,
        )),
        accentColor: const Color(0xffE0FFED),
        primaryColor:
            isDark ? const Color(0xffE0FFED) : const Color(0xff128841),
        canvasColor: Colors.black,
        hintColor: isDark ? Colors.white.withOpacity(.4) : Colors.grey,
        scaffoldBackgroundColor: isDark ? Colors.black : Colors.white,
        cardColor: isDark ? Colors.black : Colors.white,
        shadowColor: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
        brightness: isDark ? Brightness.dark : Brightness.light,
        errorColor: isDark ? Colors.redAccent : Colors.red,
        primarySwatch: myPrimaryColor(
          isDark ? const Color(0xff085E30) : const Color(0xff275739),
        ),

        fontFamily: 'Ubuntu',
        buttonTheme: ButtonThemeData(
          buttonColor:
              isDark ? const Color(0xff085E30) : const Color(0xff10B45D),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        ),
        snackBarTheme: SnackBarThemeData(
            actionTextColor: isDark ? Colors.white : Colors.black,
            backgroundColor: isDark ? Colors.white : Colors.black));
  }
}

MaterialColor myPrimaryColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
