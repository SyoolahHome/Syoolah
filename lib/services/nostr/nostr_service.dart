import 'dart:async';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/utils/routing.dart';

import 'sub_modules/send.dart';
import 'sub_modules/sub.dart';

class NostrService {
  static final NostrService _instance = NostrService._();
  static NostrService get instance => _instance;
  NostrService._();

  final consts = _MunawarahNostrConstants();

  final subs = NostrServiceSub();
  final send = NostrServiceSend();

  Completer? relaysConnectionCompleter;

  Future<void> init({
    List<String>? relaysUrls,
    bool disconnectFromAllFirst = false,
  }) async {
    relaysConnectionCompleter = Completer();
    final defaultRelaysUrls =
        Routing.appCubit.state.relaysConfigurations.map((e) => e.url).toList();

    await Nostr.instance.relaysService.init(
      relaysUrl: relaysUrls ?? defaultRelaysUrls,
      retryOnClose: true,
      shouldReconnectToRelayOnNotice: true,
      connectionTimeout: const Duration(seconds: 4),
      ensureToClearRegistriesBeforeStarting: disconnectFromAllFirst,
    );

    relaysConnectionCompleter!.complete();
  }
}

class _MunawarahNostrConstants {}
