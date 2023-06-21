import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFF0477BF),
  fontFamily: 'Lato',
  colorScheme: ColorScheme(
    primary: Color(0xFF0477BF),
    secondary: Color(0xFFED5940),
    tertiary: Color(0xFF7EB6D9),
    background: Color(0xFFF2F2F2),
    brightness: Brightness.light,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onPrimaryContainer: Colors.white70,
    error: Color(0xFFB90E0A),
    onError: Colors.white,
    onBackground: Colors.black54,
    surface: Color(0xFF0477BF),
    onSurface: Colors.white,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, height: 1.5),
    headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, height: 1.5),
    headlineSmall: TextStyle(fontSize: 16, height: 1.5),
    labelMedium: TextStyle(fontSize: 16, color: Color(0xFFED5940), fontWeight: FontWeight.w600, height: 1.5),
    bodyLarge: TextStyle(fontSize: 24, height: 1.5),
    bodyMedium: TextStyle(fontSize: 18, height: 1.5),
    bodySmall: TextStyle(fontSize: 12, height: 1.5),
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
    error: Color(0xFFB90E0A),
    onError: Colors.white,
    onBackground: Colors.black,
    surface: Color(0xFF0477BF),
    onSurface: Colors.white
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

TextTheme lightTextTheme = TextTheme(
  headlineLarge: TextStyle()
);