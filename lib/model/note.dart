import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// {@template note}
///  A model class that holds the Nostr event of a note and a parsed data that relates only to M such as a youtube video link, or images...
/// {@endtemplate}
@immutable
class Note extends Equatable {
  ///The source Nostr event of this note, where all data is derived from.
  final NostrEvent event;

  /// A list of links that are parsed from the note.
  final List<String> links;

  /// A list of image links that are parsed from the note.
  final List<String> imageLinks;

  ///A list of youtube videos links that are parsed from the note.
  final List<String> youtubeVideoLinks;

  /// The text only/content of this note excluding all other parsed members
  String noteOnly;

  @override
  List<Object?> get props => [
        event,
        noteOnly,
        links,
        imageLinks,
        youtubeVideoLinks,
      ];

  /// {@macro note}
  Note({
    required this.event,
    this.links = const [],
    this.noteOnly = "",
    this.imageLinks = const [],
    this.youtubeVideoLinks = const [],
  });

  /// {@macro note}
  /// Derives a Note directly from a Nostr event object.
  factory Note.fromEvent(NostrEvent event) {
    final links = extractLinks(event.content);
    final noteOnly = removeLinksFromInitial(event.content);
    final imageLinks = filterImageLinks(links);
    final youtubeVideoLinks = filteryoutubeVideoLinks(links);

    return Note(
      event: event,
      links: links,
      noteOnly: noteOnly,
      imageLinks: imageLinks,
      youtubeVideoLinks: youtubeVideoLinks,
    );
  }

  static List<String> extractLinks(String inputString) {
    RegExp linkRegex = RegExp(r'https?:\/\/[^\s]+');
    Iterable<Match> matches = linkRegex.allMatches(inputString);
    List<String> links = [];
    for (final Match match in matches) {
      final group = match.group(0);
      if (group != null) {
        links.add(group);
      }
    }

    return links;
  }

  static String removeLinksFromInitial(String inputString) {
    RegExp linkRegex = RegExp(r'https?:\/\/[^\s]+');

    return inputString.replaceAll(linkRegex, '').trim();
  }

  static List<String> filterImageLinks(List<String> links) {
    return links
        .where(
          (link) =>
              link.endsWith('.png') ||
              link.endsWith('.jpg') ||
              link.endsWith('.jpeg') ||
              link.endsWith('.gif'),
        )
        .toList();
  }

  static List<String> filteryoutubeVideoLinks(List<String> links) {
    return links
        .where((link) => YoutubePlayer.convertUrlToId(link) != null)
        .toList();
  }

  // generate toJson method
  Map<String, dynamic> toJson() {
    return {
      'event': event.serialized(),
      'links': links,
      'noteOnly': noteOnly,
      'imageLinks': imageLinks,
      'youtubeVideoLinks': youtubeVideoLinks,
    };
  }

  // generate fromJson method
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      event: NostrEvent.deserialized(json['event'] as String),
      links: json['links'] != null ? List<String>.from(json['links']) : [],
      noteOnly: json['noteOnly'] as String,
      imageLinks: json['imageLinks'] != null
          ? List<String>.from(json['imageLinks'])
          : [],
      youtubeVideoLinks: json['youtubeVideoLinks'] != null
          ? List<String>.from(json['youtubeVideoLinks'])
          : [],
    );
  }
}
