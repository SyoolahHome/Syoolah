import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static final primary = ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: AppColors.black,
    primaryColorLight: Colors.black54,
    primaryColorDark: Colors.black87,
    colorScheme: ColorScheme.light(
      onSecondary: AppColors.black.withOpacity(0.75),
      onSecondaryContainer: AppColors.black.withOpacity(0.05),
      background: AppColors.black,
      onBackground: AppColors.white,
      surface: AppColors.white.withOpacity(0.4),
      onSurface: Colors.white,
      onSurfaceVariant: Colors.grey[200]!,
      onInverseSurface: AppColors.lighGrey.withOpacity(.45),
      onPrimary: AppColors.lighGrey,
      errorContainer: Colors.red,
      onPrimaryContainer: AppColors.mediumGrey,
      onTertiaryContainer: AppColors.lighGrey,
    ),
    sliderTheme: SliderThemeData(
      thumbColor: AppColors.black,
      valueIndicatorColor: AppColors.black,
      activeTrackColor: AppColors.black,
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      inactiveTrackColor: AppColors.black.withOpacity(.1),
      activeTickMarkColor: AppColors.black,
      inactiveTickMarkColor: AppColors.black.withOpacity(.1),
      trackHeight: 2.5,
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: 8.0,
      ),
      overlayShape: RoundSliderOverlayShape(
        overlayRadius: 10.0,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(AppColors.black),
      checkColor: MaterialStateProperty.all(AppColors.white),
      visualDensity: VisualDensity.standard,
    ),
    scaffoldBackgroundColor: AppColors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
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
        foregroundColor: Colors.black54,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: AppColors.black,
        textStyle: const TextStyle(
          color: AppColors.white,
        ),
      ),
    ),
    dialogBackgroundColor: AppColors.lighGrey,
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.lighGrey,
      elevation: 0,
    ),
    disabledColor: Colors.black54,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.black,
      splashColor: Colors.black54,
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
    indicatorColor: AppColors.black,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.black,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.black,
      behavior: SnackBarBehavior.floating,
      closeIconColor: AppColors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.black,
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
        color: AppColors.black.withOpacity(0.55),
        fontWeight: FontWeight.normal,
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.5, horizontal: 16),
      filled: true,
      fillColor: AppColors.lighGrey,
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(size: 20, color: AppColors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    chipTheme: ChipThemeData(
      selectedColor: AppColors.lighGrey,
      checkmarkColor: AppColors.black,
      iconTheme: const IconThemeData(size: 20, grade: 5),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: AppColors.black,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColors.black,
      labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      unselectedLabelStyle:
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      unselectedLabelColor: AppColors.grey,
      overlayColor: MaterialStateProperty.all(AppColors.lighGrey),
      splashFactory: NoSplash.splashFactory,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.black,
      ),
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
    primaryColor: AppColors.black,
    primaryColorLight: Colors.black54,
    primaryColorDark: Colors.black87,
    colorScheme: ColorScheme.light(
      onSurfaceVariant: Colors.grey.withOpacity(.5),
      onSecondary: AppColors.white.withOpacity(0.9),
      onSecondaryContainer: AppColors.white.withOpacity(0.25),
      onBackground: AppColors.black,
      surface: AppColors.black.withOpacity(0.4),
      onSurface: Colors.black87,
      onInverseSurface: AppColors.lighGrey.withOpacity(.45),
      onPrimary: Colors.grey[800]!,
      errorContainer: Colors.red,
      onPrimaryContainer: Colors.grey[800],
      onTertiaryContainer: Colors.grey[900],
    ),
    sliderTheme: SliderThemeData(
      thumbColor: AppColors.white,
      valueIndicatorColor: AppColors.white,
      activeTrackColor: AppColors.white,
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      inactiveTrackColor: AppColors.white.withOpacity(.1),
      activeTickMarkColor: AppColors.white,
      inactiveTickMarkColor: AppColors.white.withOpacity(.1),
      trackHeight: 2.5,
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: 8.0,
      ),
      overlayShape: RoundSliderOverlayShape(
        overlayRadius: 10.0,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(AppColors.white),
      checkColor: MaterialStateProperty.all(AppColors.black),
      visualDensity: VisualDensity.standard,
    ),
    scaffoldBackgroundColor: AppColors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
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
        foregroundColor: Colors.black54,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: AppColors.black,
        textStyle: const TextStyle(
          color: AppColors.white,
        ),
      ),
    ),
    dialogBackgroundColor: Colors.black87,
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.black87,
      elevation: 0,
    ),
    disabledColor: Colors.black54,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.black,
      splashColor: Colors.black54,
    ),
    dividerColor: AppColors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black87,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    indicatorColor: AppColors.black,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.white,
      behavior: SnackBarBehavior.floating,
      actionTextColor: AppColors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.black,
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
      fillColor: AppColors.white.withOpacity(0.25),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(size: 20, color: AppColors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.white,
      ),
    ),
    chipTheme: ChipThemeData(
      selectedColor: AppColors.white.withOpacity(0.15),
      checkmarkColor: AppColors.white,
      iconTheme: const IconThemeData(size: 20, grade: 5),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: AppColors.black,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColors.black,
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
