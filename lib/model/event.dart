// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr/nostr.dart';

class NostrEvent extends Equatable {
  final String id;
  final int kind;
  final String content;
  final String sig;
  final String pubkey;
  final int createdAt;
  final List tags;

  const NostrEvent({
    required this.id,
    required this.kind,
    required this.content,
    required this.sig,
    required this.pubkey,
    required this.createdAt,
    required this.tags,
  });

  @override
  List<Object?> get props => [
        id,
        kind,
        content,
        sig,
        pubkey,
        createdAt,
        tags,
      ];

  Map<String, dynamic> _toMap() {
    return {
      'id': id,
      'kind': kind,
      'content': content,
      'sig': sig,
      'pubkey': pubkey,
      'created_at': createdAt,
      'tags': tags,
    };
  }

  factory NostrEvent.fromPartialData({
    required int kind,
    required String content,
    required Keychain keyChain,
  }) {
    final createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final tags = [];
    final pubkey = keyChain.public;

    final id = getEventId(
      kind: kind,
      content: content,
      createdAt: createdAt,
      tags: tags,
      pubkey: pubkey,
    );

    final sig = keyChain.sign(id);

    return NostrEvent(
      id: id,
      kind: kind,
      content: content,
      sig: sig,
      pubkey: pubkey,
      createdAt: createdAt,
      tags: tags,
    );
  }

  static String getEventId({
    required int kind,
    required String content,
    required int createdAt,
    required List tags,
    required String pubkey,
  }) {
    List data = [0, pubkey, createdAt, kind, tags, content];

    final serializedEvent = jsonEncode(data);
    final bytes = utf8.encode(serializedEvent);
    final digest = sha256.convert(bytes);
    final id = hex.encode(digest.bytes);

    return id;
  }

  List serialized() {
    return ["EVENT", _toMap()];
  }
}
