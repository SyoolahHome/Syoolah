import 'dart:math';

import 'package:flutter/material.dart';

import '../../../model/note.dart';
import '../../general/widget/margined_body.dart';
import '../../general/widget/note_card/note_card.dart';
import 'feed_page_heading.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    required this.notes,
    this.feedName,
    this.physics,
    this.shrinkWrap = false,
    this.hideCount = false,
  });

  final List<Note> notes;
  final String? feedName;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool hideCount;
  @override
  Widget build(BuildContext context) {
    if (feedName != null) {
      return MarginedBody(
        child: ListView.builder(
          physics: physics,
          shrinkWrap: shrinkWrap,
          itemCount: notes.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return FeedPageHeading(
                hideCount: hideCount,
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
          physics: physics,
          shrinkWrap: shrinkWrap,
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
