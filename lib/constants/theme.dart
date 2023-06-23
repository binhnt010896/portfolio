import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFF5FE9D0),
  fontFamily: 'Lato',
  colorScheme: ColorScheme(
      primary: Color(0xFF5FE9D0),
      secondary: Color(0x2600D9FF),
      tertiary: Color(0xFF121926),
      background: Color(0xFFFCFDFD),
      brightness: Brightness.light,
      onPrimary: Color(0xFF121926),
      onSecondary: Color(0xFF09D3FF),
      onPrimaryContainer: Color(0xFFED5940),
      error: Color(0xFFEE4B2B),
      onError: Color(0xFF121926),
      onBackground: Color(0xFFFCFDFD),
      surface: Color(0xFF0477BF),
      onSurface: Color(0xFF5FE9D0)
  ),
  buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF121926),
      textTheme: ButtonTextTheme.primary
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 36, height: 1.5, color: Color(0xFF121926)),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, height: 1.5, color: Color(0xFF121926)),
    headlineSmall: TextStyle(fontSize: 18, height: 1.5),
    labelMedium: TextStyle(fontSize: 18, color: Color(0xFF121926), height: 1.5, fontStyle: FontStyle.italic),
    labelSmall: TextStyle(fontSize: 14, height: 1.5, fontWeight: FontWeight.w600, color: Color(0xFF09D3FF)),
    bodyLarge: TextStyle(fontSize: 24, height: 1.5),
    bodyMedium: TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF121926)),
    bodySmall: TextStyle(fontSize: 12, height: 1.5),
    displayLarge: TextStyle(fontSize: 30, height: 1.5, fontWeight: FontWeight.w500),
    displayMedium: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: Color(0xFF121926)),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: Color(0xFF5FE9D0),
  fontFamily: 'Lato',
  colorScheme: ColorScheme(
    primary: Color(0xFF5FE9D0),
    secondary: Color(0x2600D9FF),
    tertiary: Colors.white,
    background: Color(0xFF121926),
    brightness: Brightness.dark,
    onPrimary: Colors.white,
    onSecondary: Color(0xFF09D3FF),
    onPrimaryContainer: Color(0xFFED5940),
    error: Color(0xFFEE4B2B),
    onError: Colors.white,
    onBackground: Colors.black,
    surface: Color(0xFF0477BF),
    onSurface: Color(0xFF5FE9D0)
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white,
    textTheme: ButtonTextTheme.primary
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 36, height: 1.5, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, height: 1.5, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 18, height: 1.5),
    labelMedium: TextStyle(fontSize: 18, color: Colors.white, height: 1.5, fontStyle: FontStyle.italic),
    labelSmall: TextStyle(fontSize: 14, height: 1.5, fontWeight: FontWeight.w600, color: Color(0xFF09D3FF)),
    bodyLarge: TextStyle(fontSize: 24, height: 1.5),
    bodyMedium: TextStyle(fontSize: 16, height: 1.5, color: Colors.white),
    bodySmall: TextStyle(fontSize: 12, height: 1.5),
    displayLarge: TextStyle(fontSize: 30, height: 1.5, fontWeight: FontWeight.w500),
    displayMedium: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: Colors.white),
  ),
);
