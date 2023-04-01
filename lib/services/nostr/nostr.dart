import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/nostr/base/nostr.dart';
import 'package:flutter/material.dart';
import 'package:nostr/nostr.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'model/event.dart';
import 'model/request.dart';

final relaysUrl = 'wss://relay.damus.io';

final NostrService _instance = NostrService._();

class NostrService implements NostrServiceBase {
  static NostrService get instance => _instance;

  final _streamController = StreamController<NostrEvent>.broadcast();

  Stream<NostrEvent> get stream => _streamController.stream;

  NostrService._();

  WebSocket? ws;

  WebSocket get wsChannel {
    assert(ws != null);

    return ws!;
  }

  @override
  String generateKeys() {
    final keyChain = Keychain.generate();

    return keyChain.private;
  }

  Future<void> init() async {
    ws = await WebSocket.connect("wss://relay.damus.io");

    wsChannel.listen((d) {
      print("received: $d");
      final canBeDeserializedEvent = NostrEvent.canBeDeserializedEvent(d);

      if (canBeDeserializedEvent) {
        _streamController.sink.add(NostrEvent.fromRelayMessage(d));
      }
    }, onError: (e) {
      print("error");
      print(e);
    }, onDone: () {
      print('in onDone');
      ws!.close();
    });
  }

  void setCurrentUserMetaData({
    required String name,
    String? username,
    String? picture,
    String? banner,
    String? about,
    DateTime? creationDate,
  }) {
    final keyChain = Keychain(LocalDatabase.instance.getPrivateKey()!);

    final event = NostrEvent.fromPartialData(
      kind: 0,
      keyChain: keyChain,
      content: jsonEncode({
        "name": name,
        "creationDate": (creationDate ?? DateTime.now()).toIso8601String(),
        if (picture != null) "picture": picture,
        if (banner != null) "banner": banner,
        if (about != null) "about": about,
        if (username != null) "username": username,
      }),
    );

    final serialized = event.serialized();

    debugPrint("sending metadata event: $serialized");
    wsChannel.add(serialized);
  }

  sendReq() {}

  @override
  Stream<NostrEvent> currentUserMetaDataStream() {
    final keyChain = Keychain(LocalDatabase.instance.getPrivateKey()!);
    final metaDataSubscription = generate64RandomHexChars();

    final requestWithFilter = Request(metaDataSubscription, [
      Filter(
        authors: [keyChain.public],
        kinds: [0],
        since: 1674063680,
        limit: 450,
      )
    ]);
    wsChannel.add(requestWithFilter.serialize());

    return stream.where((event) {
      return event.subscriptionId == metaDataSubscription;
    });
  }
}
