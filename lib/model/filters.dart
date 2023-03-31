import 'dart:convert';

import 'package:equatable/equatable.dart';

class Filters extends Equatable {
  final List<String> ids;
  final List<String> authors;
  final List<int> kinds;
  final List<String> e;
  final List<String> p;
  final int since;
  final int until;
  final int limit;

  const Filters({
    required this.ids,
    required this.authors,
    required this.kinds,
    required this.e,
    required this.p,
    required this.since,
    required this.until,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      "ids": ids,
      "authors": authors,
      "kinds": kinds,
      "#e": e,
      "#p": p,
      "since": since,
      "until": until,
      "limit": limit,
    };
  }

  String toJson() => jsonEncode(toMap());
  @override
  List<Object?> get props => [
        ids,
        authors,
        kinds,
        e,
        p,
        since,
        until,
        limit,
      ];
}
