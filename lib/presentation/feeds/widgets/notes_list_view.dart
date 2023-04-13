import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../model/note.dart';
import '../../general/widget/margined_body.dart';
import '../../general/widget/note_card/note_card.dart';
import 'feed_page_heading.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    required this.notes,
    this.feedName,
  });

  final List<Note> notes;
  final String? feedName;

  @override
  Widget build(BuildContext context) {
    if (feedName != null) {
      return MarginedBody(
        child: ListView.builder(
          itemCount: notes.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return FeedPageHeading(
                feedName: feedName!,
                notesLength: max(notes.length - 1, 0),
              );
            }
            return NoteCard(
              note: notes[index - 1],
            );
          },
        ),
      );
    } else {
      return MarginedBody(
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteCard(
              note: notes[index],
            );
          },
        ),
      );
    }
  }
}
