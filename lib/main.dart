import 'package:device_preview/device_preview.dart';
import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/constants/app_themes.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/utils/app_utils.dart';

Future<void> main() async {
  await AppUtils.instance.initialize();

  Widget appMainWidget = MyApp();

  final localizationWidget = EasyLocalization(
    supportedLocales: AppConfigs.locales,
    path: AppConfigs.translationsPath,
    fallbackLocale: AppConfigs.fallbackLocale,
    child: appMainWidget,
  );

  appMainWidget = AppConfigs.showPreviewMode
      ? DevicePreview(
          enabled: AppConfigs.showPreviewMode,
          builder: (context) => localizationWidget,
        )
      : localizationWidget;

  runApp(appMainWidget);
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
        BlocProvider<AppCubit>.value(value: Routing.appCubit),
      ],
      child: StreamBuilder<bool>(
        stream: LocalDatabase.instance.themeStateListenable(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
