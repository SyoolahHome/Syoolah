import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../model/note.dart';
import 'note_follow_button.dart';
import 'note_owner_avatar.dart';
import 'note_owner_username.dart';

class NoteAvatarAndName extends StatelessWidget {
  const NoteAvatarAndName({
    super.key,
    required this.avatarUrl,
    required this.nameToShow,
    required this.memeberShipStartedAt,
    required this.note,
  });

  final String avatarUrl;
  final String nameToShow;
  final DateTime memeberShipStartedAt;
  final Note note;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        NoteOwnerAvatar(avatarUrl: avatarUrl),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoteOwnerUsername(nameToShow: nameToShow),
            Text(
              memeberShipStartedAt.memberForTime(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.grey,
                    letterSpacing: 0.1,
                  ),
            )
          ],
        ),
        const Spacer(),
        NoteFollowButton(note: note),
      ],
    );
  }
}
