import 'package:ditto/model/note.dart';
import 'package:flutter/material.dart';

import '../../general/widget/margined_body.dart';
import '../../general/widget/note_card/wudgets/note_avatat_and_name.dart';
import '../../general/widget/note_card/wudgets/note_bg.dart';
import '../../general/widget/note_card/wudgets/note_contents.dart';

class NotePlaceholderCard extends StatelessWidget {
  const NotePlaceholderCard({
    super.key,
    required this.note,
  });

  final Note note;
  @override
  Widget build(BuildContext context) {
    return NoteContainer(
      key: ValueKey(note.event.uniqueTag()),
      note: note,
      margin: MarginedBody.defaultMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),

          const SizedBox(height: 15),
          NoteContents(
            youtubeVideosLinks: note.youtubeVideoLinks,
            heroTag: note.event.uniqueTag(),
            imageLinks: note.imageLinks,
            text: note.noteOnly,
          ),
          // NoteActions(note: note),
        ],
      ),
    );
  }
}
