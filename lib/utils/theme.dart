import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTheme {
  static final theme = ThemeData(
    primarySwatch: Colors.indigo,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      foregroundColor: primary,
      centerTitle: true,
      toolbarHeight: 90,
    ),
    scaffoldBackgroundColor: const Color(0xFFF2F2F3),
  );
}
