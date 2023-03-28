import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppThemes {
  static ThemeData primary = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.teal,
      indicatorColor: AppColors.white.withOpacity(0.3),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.white.withOpacity(0.3),
      filled: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        color: AppColors.white.withOpacity(0.55),
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
