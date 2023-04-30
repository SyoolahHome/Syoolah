import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppThemes {
  static ThemeData primary = ThemeData.light().copyWith(
    primaryColor: AppColors.teal,
    primaryColorLight: AppColors.tealLight,
    primaryColorDark: AppColors.tealDark,
    colorScheme: ColorScheme.light(
      onSecondaryContainer: AppColors.black.withOpacity(0.05),
      onSecondary: AppColors.black.withOpacity(0.75),
    ),
    scaffoldBackgroundColor: AppColors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: AppColors.white.withOpacity(0.85),
      backgroundColor: AppColors.teal,
      elevation: 0,
      unselectedIconTheme: IconThemeData(
        color: AppColors.white.withOpacity(0.85),
        size: 19,
      ),
      selectedIconTheme: const IconThemeData(
        color: AppColors.white,
        size: 19,
      ),
    ),
    brightness: Brightness.light,
    cardColor: AppColors.lighGrey,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        animationDuration: const Duration(milliseconds: 200),
        foregroundColor: AppColors.tealLight,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: AppColors.teal,
        textStyle: const TextStyle(
          color: AppColors.white,
        ),
      ),
    ),
    dialogBackgroundColor: AppColors.lighGrey,
    disabledColor: AppColors.tealLight,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.teal,
      foregroundColor: AppColors.white,
      splashColor: AppColors.tealLight,
    ),
    dividerColor: AppColors.white,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.lighGrey,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    indicatorColor: AppColors.teal,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.teal,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: AppColors.black,
      closeIconColor: AppColors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.teal,
      labelTextStyle: MaterialStateProperty.all(TextStyle(
        color: AppColors.white.withOpacity(0.85),
        fontWeight: FontWeight.w500,
        fontSize: 12,
      )),
      indicatorColor: AppColors.white.withOpacity(0.3),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(color: AppColors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.teal.withOpacity(0.5),
        animationDuration: const Duration(milliseconds: 200),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textStyle: TextStyle(color: AppColors.teal),
      ),
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
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.teal,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: AppColors.black,
        size: 20,
      ),
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
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green.withOpacity(0.25);
          }
          return Colors.red.withOpacity(0.25);
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green.withOpacity(0.5);
          }
          return Colors.red.withOpacity(0.5);
        },
      ),
      thumbColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          return Colors.red;
        },
      ),
      thumbIcon: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return const Icon(Icons.check);
          }
          return const Icon(Icons.close);
        },
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );

  // dark theme
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.teal,
    primaryColorLight: AppColors.tealLight,
    primaryColorDark: AppColors.tealDark,
    colorScheme: ColorScheme.light(
      onSecondaryContainer: AppColors.white.withOpacity(0.25),
      onSecondary: AppColors.white.withOpacity(0.9),
    ),
    scaffoldBackgroundColor: AppColors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: AppColors.white.withOpacity(0.85),
      backgroundColor: AppColors.teal,
      elevation: 0,
      unselectedIconTheme: IconThemeData(
        color: AppColors.white.withOpacity(0.85),
        size: 19,
      ),
      selectedIconTheme: const IconThemeData(
        color: AppColors.white,
        size: 19,
      ),
    ),
    brightness: Brightness.dark,
    cardColor: AppColors.lighGrey,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        animationDuration: const Duration(milliseconds: 200),
        foregroundColor: AppColors.tealLight,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: AppColors.teal,
        textStyle: const TextStyle(
          color: AppColors.white,
        ),
      ),
    ),
    dialogBackgroundColor: AppColors.lighGrey,
    disabledColor: AppColors.tealLight,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.teal,
      foregroundColor: AppColors.white,
      splashColor: AppColors.tealLight,
    ),
    dividerColor: AppColors.white,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.lighGrey,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    indicatorColor: AppColors.teal,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.teal,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: AppColors.black,
      closeIconColor: AppColors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.teal,
      labelTextStyle: MaterialStateProperty.all(TextStyle(
        color: AppColors.white.withOpacity(0.85),
        fontWeight: FontWeight.w500,
        fontSize: 12,
      )),
      indicatorColor: AppColors.white.withOpacity(0.3),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(color: AppColors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.teal.withOpacity(0.5),
        animationDuration: const Duration(milliseconds: 200),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textStyle: TextStyle(color: AppColors.teal),
      ),
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
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.teal,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: AppColors.black,
        size: 20,
      ),
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
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green.withOpacity(0.25);
          }
          return Colors.red.withOpacity(0.25);
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green.withOpacity(0.5);
          }
          return Colors.red.withOpacity(0.5);
        },
      ),
      thumbColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          return Colors.red;
        },
      ),
      thumbIcon: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return const Icon(Icons.check);
          }
          return const Icon(Icons.close);
        },
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
