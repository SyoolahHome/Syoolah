import 'dart:io';

import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'constants/app_strings.dart';
import 'constants/app_themes.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  Animate.restartOnHotReload = kDebugMode;

  Animate.defaultCurve = Curves.easeInOut;

  await LocalDatabase.instance.init();
  NostrService.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => Routing.authCubit,
          lazy: false,
        ),
        BlocProvider<HomePageAfterLoginCubit>.value(
          value: Routing.homePageAfterLoginCubit,
        ),
        BlocProvider<AppCubit>.value(
          value: Routing.appCubit,
        ),
      ],
      child: StreamBuilder(
        stream: LocalDatabase.instance.themeStateListenable(),
        builder: (context, snapshot) {
          final themeMode = LocalDatabase.instance.getThemeState()
              ? ThemeMode.dark
              : ThemeMode.light;

          return MaterialApp(
            routes: Routing.routes,
            initialRoute: Paths.onBoarding,
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.primary,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
