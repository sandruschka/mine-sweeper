import 'package:flutter/material.dart';

class MineSweeperTheme {
  ThemeData get themeData {
    ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(0, 128, 128, 1),
      onPrimary: Color.fromRGBO(0, 0, 0, 1),
      secondary: Color.fromRGBO(0, 0, 128, 1),
      onSecondary: Color.fromRGBO(0, 0, 0, 1),
      error: Color.fromRGBO(255, 0, 0, 1),
      onError: Color.fromRGBO(0, 0, 0, 1),
      background: Color.fromRGBO(192, 192, 192, 1),
      onBackground: Color.fromRGBO(0, 0, 0, 1),
      surface: Color.fromRGBO(0, 0, 0, 1),
      onSurface: Color.fromRGBO(0, 0, 0, 1),
    );
    return ThemeData.from(colorScheme: colorScheme);
  }
}
