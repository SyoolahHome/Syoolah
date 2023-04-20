// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final NostrEvent event;
  late List<String> links;
  final List<String> imageLinks;
  late String noteOnly;

  Note({
    required this.event,
    this.links = const [],
    this.noteOnly = "",
    this.imageLinks = const [],
  });

  factory Note.fromEvent(
    NostrEvent event,
  ) {
    final links = extractLinks(event.content);
    final noteOnly = removeLinksFromInitial(event.content);
    final imageLinks = filterImageLinks(links);

    return Note(
      event: event,
      links: links,
      imageLinks: imageLinks,
      noteOnly: noteOnly,
    );
  }

  @override
  List<Object?> get props => [
        event,
        noteOnly,
        links,
        imageLinks,
      ];
}

List<String> extractLinks(String inputString) {
  RegExp linkRegex = RegExp(r'https?:\/\/[^\s]+');
  Iterable<Match> matches = linkRegex.allMatches(inputString);
  List<String> links = [];
  for (Match match in matches) {
    links.add(match.group(0)!);
  }
  return links;
}

String removeLinksFromInitial(String inputString) {
  RegExp linkRegex = RegExp(r'https?:\/\/[^\s]+');
  return inputString.replaceAll(linkRegex, '').trim();
}

List<String> filterImageLinks(List<String> links) {
  return links
      .where((link) =>
          link.endsWith('.png') ||
          link.endsWith('.jpg') ||
          link.endsWith('.jpeg') ||
          link.endsWith('.gif'))
      .toList();
}
