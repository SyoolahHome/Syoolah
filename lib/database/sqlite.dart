import 'dart:convert';
import 'dart:io';
import 'package:ditto/database/utils.dart';
import 'package:nostr/nostr.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';

void initialize() {
  return;
}

void createDatabase() {
  return;
}

Future<Database> getDatabase() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  return sqlite3.open(appDocPath);
}

void createTable(Database db) {
  db.execute('''
    CREATE TABLE events (
      id TEXT NOT NULL PRIMARY KEY,
      pubkey TEXT NOT NULL,
      created_at INTEGER NOT NULL,
      kind INTEGER NOT NULL,
      tags TEXT NOT NULL,
      content TEXT NOT NULL,
      sig TEXT NOT NULL
    );
  ''');
}

void insertEvent(Database db, List<Event> events) {
  PreparedStatement statement = db.prepare(
      'INSERT INTO events (id, pubkey, created_at, kind, tags, content, sig) VALUES (?,?,?,?,?,?,?)');
  for (Event event in events) {
    statement.execute([
      event.id,
      event.pubkey,
      event.createdAt,
      event.kind,
      jsonEncode(event.tags),
      event.content,
      event.sig,
    ]);
  }
  statement.dispose();
}

List<Event> getEvents(Database db, DateTime start, DateTime? stop) {
  ResultSet rows;
  List<Event> result = [];
  if (stop == null) {
    rows = db.select('SELECT * FROM events WHERE created_at >= ?',
        [toSecondsTimestamp(start)]);
  } else {
    rows = db.select(
        'SELECT * FROM events WHERE created_at >= ? AND created_at <= ?', [
      toSecondsTimestamp(start),
      toSecondsTimestamp(stop),
    ]);
  }
  for (final Row row in rows) {
    result.add(toEvent(row));
  }
  return result;
}

void main(List<String> args) async {
  print('Using sqlite3 ${sqlite3.version}');
  var db = await getDatabase();
  createTable(db);
  insertEvent(db, [
    Event.partial(createdAt: toSecondsTimestamp(DateTime.now()), tags: [
      [
        "e",
        "343ed9c6ca7a0a8f33f8cfed04b6cea4a4dda50a649daffaf85d6410507c5c7c",
        "wss://relay.damus.io",
        "reply"
      ],
      ["p", "7b6461d02c6f0be1cacdcf968c4246105a2db51c7770993bf8bb25e59cedffa7"]
    ])
  ]);
  var tmp = getEvents(db, toDateTime(1676223011), null);
  print(tmp);
}
