import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/constants/app_themes.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  Animate.restartOnHotReload = kDebugMode;
  Animate.defaultCurve = Curves.easeInOut;

  final box = await LocalDatabase.instance.init();

  NostrService.instance.init();

  await EasyLocalization.ensureInitialized();

  Bloc.observer = Routing.blocObserver;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Widget appMainWidget = MyApp();

  if (AppConfigs.showPreviewMode) {
    appMainWidget = DevicePreview(
        enabled: true,
        builder: (context) => EasyLocalization(
              supportedLocales: AppConfigs.locales,
              path: AppConfigs.translationsPath,
              fallbackLocale: AppConfigs.fallbackLocale,
              child: appMainWidget,
            ));
  } else {
    appMainWidget = EasyLocalization(
      supportedLocales: AppConfigs.locales,
      path: AppConfigs.translationsPath,
      fallbackLocale: AppConfigs.fallbackLocale,
      child: appMainWidget,
    ); // Wrap your app
  }

  runApp(appMainWidget);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (context) => Routing.authCubit, lazy: false),
        BlocProvider<HomePageAfterLoginCubit>.value(
          value: Routing.homePageAfterLoginCubit,
        ),
        BlocProvider<AppCubit>.value(value: Routing.appCubit),
      ],
      child: StreamBuilder(
        stream: LocalDatabase.instance.themeStateListenable(),
        builder: (context, snapshot) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            locale: AppConfigs.showPreviewMode
                ? DevicePreview.locale(context)
                : context.locale,
            builder:
                AppConfigs.showPreviewMode ? DevicePreview.appBuilder : null,
            routes: Routing.routes,
            initialRoute: Paths.initialRoute,
            title: "Munawarah",
            themeMode: ThemeMode.light
                .decideBasedOnLocaleThemeStatusButDefaultToSystemOnFirstTime(),
            theme: AppThemes.primary,
            darkTheme: AppThemes.darkTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}
