import 'dart:convert';

import 'package:nostr/nostr.dart';
import 'package:sqlite3/sqlite3.dart';

DateTime toDateTime(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
}

int toSecondsTimestamp(DateTime datetime) {
  return datetime.toUtc().millisecondsSinceEpoch ~/ 1000;
}

Event toEvent(Row row) {
  return Event(
    row['id'],
    row['pubkey'],
    row['created_at'],
    row['kind'],
    (jsonDecode(row['tags']) as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList(),
    row['content'],
    row['sig'],
  );
}
