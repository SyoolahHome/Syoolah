import 'package:ditto/model/note.dart';
import 'package:flutter/material.dart';

import '../../general/widget/note_card/wudgets/note_avatat_and_name.dart';
import '../../general/widget/note_card/wudgets/note_bg.dart';
import '../../general/widget/note_card/wudgets/note_contents.dart';

class NotePlaceholderCard extends StatelessWidget {
  const NotePlaceholderCard({
    super.key,
    required this.note,
    required this.nameToShow,
    required this.noteOwnerUserPubKey,
    required this.avatarUrl,
    required this.appCurrentUserPublicKey,
  });

  final Note note;
  final String nameToShow;
  final String avatarUrl;
  final String appCurrentUserPublicKey;
  final String noteOwnerUserPubKey;
  @override
  Widget build(BuildContext context) {
    return NoteContainer(
      key: ValueKey(note.event.id),
      note: note,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 15),
          NoteAvatarAndName(
            avatarUrl: avatarUrl,
            nameToShow: nameToShow,
            userPubKey: noteOwnerUserPubKey,
            appCurrentUserPublicKey: appCurrentUserPublicKey,
          ),
          const SizedBox(height: 15),
          NoteContents(
            youtubeVideosLinks: note.youtubeVideoLinks,
            heroTag: note.event.id,
            imageLinks: note.imageLinks,
            text: note.noteOnly,
          ),
          // NoteActions(note: note),
        ],
      ),
    );
  }
}
