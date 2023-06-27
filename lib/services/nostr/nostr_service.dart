import 'dart:async';
import 'dart:convert';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/model/report_option.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';

import 'sub_modules/send.dart';
import 'sub_modules/sub.dart';

class NostrService {
  static final NostrService _instance = NostrService._();
  static NostrService get instance => _instance;
  NostrService._();

  final subs = NostrServiceSub();
  final send = NostrServiceSend();

  Completer? relaysConnectionCompleter;

  Future<void> init({
    List<String>? relaysUrls,
  }) async {
    relaysConnectionCompleter = Completer();
    final defaultRelaysUrls =
        Routing.appCubit.state.relaysConfigurations.map((e) => e.url).toList();

    await Nostr.instance.relaysService.init(
      relaysUrl: relaysUrls ?? defaultRelaysUrls,
      retryOnClose: true,
      shouldReconnectToRelayOnNotice: true,
      connectionTimeout: const Duration(seconds: 4),
    );

    relaysConnectionCompleter!.complete();
  }
}
