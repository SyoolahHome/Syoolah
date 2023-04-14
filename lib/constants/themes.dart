import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppThemes {
  static ThemeData primary = ThemeData.light().copyWith(
    useMaterial3: true,
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
    textTheme: GoogleFonts.latoTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.teal,
      iconTheme: const IconThemeData(color: AppColors.white),
    ),
    chipTheme: ChipThemeData(
      selectedColor: AppColors.teal.withOpacity(0.1),
      checkmarkColor: AppColors.teal,
      iconTheme: const IconThemeData(
        grade: 5,
        size: 20,
      ),
    ),
    
    tabBarTheme: TabBarTheme(
      labelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      labelColor: AppColors.teal,
      indicatorColor: AppColors.teal,
      indicatorSize: TabBarIndicatorSize.label,
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all(AppColors.lighGrey),
    ),
  );
}
