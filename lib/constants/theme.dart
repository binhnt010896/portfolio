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
    // onPrimaryContainer: Color(0xFFED5940),
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
  primaryColor: Color(0xFF386785),
  fontFamily: 'Lato',
  colorScheme: ColorScheme(
    primary: Color(0xFF386785),
    secondary: Color(0xFF05EBC7),
    tertiary: Color(0xFF7EB6D9),
    background: Color(0xFF313536),
    brightness: Brightness.dark,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onPrimaryContainer: Color(0xFFED5940),
    error: Color(0xFFB90E0A),
    onError: Colors.white,
    onBackground: Colors.white,
      surface: Color(0xFF0477BF),
      onSurface: Colors.white
  ),
  textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: 24),
      labelMedium: TextStyle(fontSize: 16, color: Color(0xFF0477BF))
  ),
);

TextTheme lightTextTheme = TextTheme(
  headlineLarge: TextStyle()
);