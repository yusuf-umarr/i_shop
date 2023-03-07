import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      colorScheme: const ColorScheme.dark(
          // primary: Color(0xFF1C1C1E),
          // onPrimary: Color(0xff0F82D6),
          // secondary: Color(0xff0F82D6),
          // onSecondary: Color(0xFFFFFFFF),
          // error: Color(0xFF000000),
          // onError: Color(0xFFF20B0B),
          // background: Color(0xFF1C1C1E),
          // onBackground: Color(0xFFFFFFFF),
          // surface: Color(0xFF000000),
          // onSurface: Color(0xFFFFFFFF),
          // tertiary: Color(0xFF909090),
          // onTertiaryContainer: Color(0xFF1C1C1E),

          ),
      fontFamily: "inter",
      appBarTheme: _fAppbarTheme(
        Color(0xFFFFFFFF),
        Color(0xFF1C1C1E),
      ),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: Color(0xFF909090)),
      textTheme: _textTheme());

  static final lightTheme = ThemeData(
      colorScheme: const ColorScheme.light(
          // primary: Color(0xFFFFFFFF),
          // onPrimary: Color(0xff0F82D6),
          // secondary: Color(0xff0F82D6),
          // onSecondary: Color(0xFF000000),
          // error: Color(0xFFFFFFFF),
          // onError: Color(0xFFF20B0B),
          // background: Color(0xFFFFFFFF),
          // onBackground: Color(0xFF1C1C1E),
          // surface: Color(0xFFFFFFFF),
          // onSurface: Color(0xFF1C1C1E),
          // tertiary: Color(0xFF909090),
          // onTertiaryContainer: Color(0xFFE9E8E8),
          ),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: Color(0xFF909090)),
      textTheme: _textTheme());

  static _fAppbarTheme(Color? color, Color bgColor) => AppBarTheme(
      elevation: 1,
      titleTextStyle: TextStyle(color: color),
      iconTheme: IconThemeData(color: color),
      backgroundColor: bgColor);

  static TextTheme _textTheme() => TextTheme(
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          // color: colorScheme.onBackground,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          // color: colorScheme.onBackground,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          // color: colorScheme.onBackground,
        ),
        bodyMedium: TextStyle(
            // color: colorScheme.onSurface,
            ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          // color: colorScheme.onPrimary,
        ),
      );
}
