// ignore_for_file: no-equal-arguments

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppThemes {
  static final primary = ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: AppColors.teal,
    primaryColorLight: AppColors.tealLight,
    primaryColorDark: AppColors.tealDark,
    colorScheme: ColorScheme.light(
      onSecondary: AppColors.black.withOpacity(0.75),
      onSecondaryContainer: AppColors.black.withOpacity(0.05),
      background: AppColors.black,
      onBackground: AppColors.white,
      surface: AppColors.white.withOpacity(0.4),
      onSurface: Colors.white,
      onInverseSurface: AppColors.lighGrey.withOpacity(.45),
    ),
    scaffoldBackgroundColor: AppColors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.teal,
      elevation: 0,
      selectedIconTheme: const IconThemeData(size: 19, color: AppColors.white),
      unselectedIconTheme:
          IconThemeData(size: 19, color: AppColors.white.withOpacity(0.85)),
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white.withOpacity(0.85),
      showSelectedLabels: false,
      showUnselectedLabels: false,
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
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.teal,
      splashColor: AppColors.tealLight,
    ),
    dividerColor: AppColors.black,
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
      backgroundColor: AppColors.black,
      behavior: SnackBarBehavior.floating,
      closeIconColor: AppColors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.teal,
      indicatorColor: AppColors.white.withOpacity(0.3),
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(
          color: AppColors.white.withOpacity(0.85),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(color: AppColors.white),
      ),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
      hintStyle: TextStyle(
        color: AppColors.white.withOpacity(0.55),
        fontWeight: FontWeight.normal,
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.5, horizontal: 16),
      filled: true,
      fillColor: AppColors.white.withOpacity(0.3),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.teal,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(size: 20, color: AppColors.black),
    ),
    chipTheme: ChipThemeData(
      selectedColor: AppColors.teal.withOpacity(0.1),
      checkmarkColor: AppColors.teal,
      iconTheme: const IconThemeData(size: 20, grade: 5),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: AppColors.teal,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColors.teal,
      labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      unselectedLabelStyle:
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      overlayColor: MaterialStateProperty.all(AppColors.lighGrey),
      splashFactory: NoSplash.splashFactory,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }

          return Colors.red;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.green.withOpacity(0.25);
        }

        return Colors.red.withOpacity(0.25);
      }),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green.withOpacity(0.5);
          }

          return Colors.red.withOpacity(0.5);
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
    ),
  );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: AppColors.teal,
    primaryColorLight: AppColors.tealLight,
    primaryColorDark: AppColors.tealDark,
    colorScheme: ColorScheme.light(
      onSecondary: AppColors.white.withOpacity(0.9),
      onSecondaryContainer: AppColors.white.withOpacity(0.25),
      background: AppColors.white,
      onBackground: AppColors.black,
      surface: AppColors.black.withOpacity(0.4),
      onSurface: Colors.black87,
      onInverseSurface: AppColors.lighGrey.withOpacity(.45),
    ),
    scaffoldBackgroundColor: AppColors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.teal,
      elevation: 0,
      selectedIconTheme: const IconThemeData(size: 19, color: AppColors.white),
      unselectedIconTheme:
          IconThemeData(size: 19, color: AppColors.white.withOpacity(0.85)),
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white.withOpacity(0.85),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    brightness: Brightness.dark,
    cardColor: AppColors.lighGrey.withOpacity(0.15),
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
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.teal,
      splashColor: AppColors.tealLight,
    ),
    dividerColor: AppColors.white,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black87,
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
      backgroundColor: AppColors.black,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: AppColors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.teal,
      indicatorColor: AppColors.white.withOpacity(0.3),
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(
          color: AppColors.white.withOpacity(0.85),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(color: AppColors.white),
      ),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
      hintStyle: TextStyle(
        color: AppColors.white.withOpacity(0.55),
        fontWeight: FontWeight.normal,
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.5, horizontal: 16),
      filled: true,
      fillColor: AppColors.white.withOpacity(0.3),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.teal,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(size: 20, color: AppColors.black),
    ),
    chipTheme: ChipThemeData(
      selectedColor: AppColors.teal.withOpacity(0.1),
      checkmarkColor: AppColors.teal,
      iconTheme: const IconThemeData(size: 20, grade: 5),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: AppColors.teal,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColors.teal,
      labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      unselectedLabelStyle:
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      overlayColor: MaterialStateProperty.all(AppColors.lighGrey),
      splashFactory: NoSplash.splashFactory,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }

          return Colors.red;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green.withOpacity(0.25);
          }

          return Colors.red.withOpacity(0.25);
        },
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green.withOpacity(0.5);
          }

          return Colors.red.withOpacity(0.5);
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
    ),
  );
}
