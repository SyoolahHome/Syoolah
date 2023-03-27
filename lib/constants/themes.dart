import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppThemes {
  static ThemeData primary = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.white.withOpacity(0.3),
      filled: true,
          ),
  );
}
