// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Note extends Equatable {
  final NostrEvent event;
  final List<String> links;
  final List<String> imageLinks;
  final List<String> youtubeVideoLinks;
  String noteOnly;

  @override
  List<Object?> get props => [
        event,
        noteOnly,
        links,
        imageLinks,
        youtubeVideoLinks,
      ];

  Note({
    required this.event,
    this.links = const [],
    this.noteOnly = "",
    this.imageLinks = const [],
    this.youtubeVideoLinks = const [],
  });

  factory Note.fromEvent(
    NostrEvent event,
  ) {
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
        .where((link) => YoutubePlayerController.convertUrlToId(link) != null)
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
      event: NostrEvent.deserialized(json['event'] as String) as NostrEvent,
      links: List<String>.from(json['links'] as List) ?? [],
      noteOnly: json['noteOnly'] as String,
      imageLinks:
          List<String>.from(json['imageLinks'] as List) as List<String> ?? [],
      youtubeVideoLinks: List<String>.from(json['youtubeVideoLinks'] as List)
              as List<String> ??
          [],
    );
  }
}
