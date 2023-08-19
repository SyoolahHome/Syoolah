import 'dart:io';
import 'dart:math';

import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/app_enums.dart';
import '../database/local/local_database.dart';
import '../database/local/local_database.dart';
import '../nostr/nostr_service.dart';
import 'arabix_adapter_utils.dart';

class AppUtils with ArabicAdapterUtils {
  static AppUtils _instance = AppUtils._();
  static AppUtils get instance => _instance;

  AppUtils._();

  int chatUserIdCounter = 0;
  int chatSystemIdCounter = 0;

  String randomChatMessagePlaceholder() {
    final randomNumber =
        Random().nextInt(AppConfigs.chatMessagePlaceholders.length);

    return AppConfigs.chatMessagePlaceholders[randomNumber];
  }

  String getChatUserId() {
    chatUserIdCounter--;
    return chatUserIdCounter.toString();
  }

  String getChatSystemId() {
    chatSystemIdCounter++;
    return chatSystemIdCounter.toString();
  }

  ScaffoldFeatureController displaySnackBar(
    BuildContext context,
    String content,
  ) {
    SnackBar snackBar = SnackBar(
      content: Text(content),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> copy(
    String text, {
    void Function()? onSuccess,
    void Function()? onError,
    void Function()? onEnd,
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      onSuccess?.call();
    } catch (e) {
      onError?.call();
    } finally {
      onEnd?.call();
    }
  }

  String appLogoSelector(AppLogoStyle style) {
    switch (style) {
      case AppLogoStyle.white:
        return 'assets/logo/white_no_bg.png';

      case AppLogoStyle.black:
        return 'assets/logo/black_no_bg.png';

      default:
        throw Exception('Invalid AppLogoStyle');
    }
  }

  Widget widgetFromRoutePath(String path, BuildContext context) {
    if (Routing.routes[path] != null) {
      return Routing.routes[path]!(context);
    } else {
      throw Exception('Invalid route path');
    }
  }

  Future<void> changeLocale(BuildContext context, Locale locale) {
    return context.setLocale(locale);
  }

  Future<void> initialize() async {
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
  }

  IconData directionality_arrow_left_fill(BuildContext context) {
    return directionalityIcon(
      context,
      onArabicIcon: FlutterRemix.arrow_right_fill,
      onNonArabicIcon: FlutterRemix.arrow_left_fill,
    );
  }

  IconData directionality_arrow_left_line(BuildContext context) {
    return directionalityIcon(
      context,
      onArabicIcon: FlutterRemix.arrow_right_line,
      onNonArabicIcon: FlutterRemix.arrow_left_line,
    );
  }

  IconData directionality_arrow_right_s_line(BuildContext context) {
    return directionalityIcon(
      context,
      onArabicIcon: FlutterRemix.arrow_left_s_line,
      onNonArabicIcon: FlutterRemix.arrow_right_s_line,
    );
  }

  IconData directionality_arrow_right_line(BuildContext context) {
    return directionalityIcon(
      context,
      onArabicIcon: FlutterRemix.arrow_left_line,
      onNonArabicIcon: FlutterRemix.arrow_right_line,
    );
  }

  Alignment centerHorizontalAlignment(BuildContext context) {
    return isArabic(context) ? Alignment.centerLeft : Alignment.centerRight;
  }

  Alignment centerTextHorizontalAlignment(BuildContext context) {
    return isArabic(context) ? Alignment.centerRight : Alignment.centerLeft;
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
