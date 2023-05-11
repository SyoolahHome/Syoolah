import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../buisness_logic/users_list_to_follow_cubit/users_list_to_follow_cubit.dart';
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
    this.note,
    required this.userPubKey,
    this.showFollowButton = false,
  });

  final String avatarUrl;
  final String nameToShow;
  final DateTime memeberShipStartedAt;
  final Note? note;
  final String userPubKey;
  final bool showFollowButton;
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
                    color: DefaultTextStyle.of(context)
                        .style
                        .color!
                        .withOpacity(.65),
                    letterSpacing: 0.1,
                  ),
            )
          ],
        ),
        const Spacer(),
        if (note != null) ...[
          NoteFollowButton(note: note!),
        ],
        if (showFollowButton) ...[
          MunawarahButton(
            isSmall: true,
            text: context
                    .read<UsersListToFollowCubit>()
                    .isNoteOwnerFollowed(userPubKey)
                ? "Following"
                : "Follow",
            onTap: () {
              context
                  .read<UsersListToFollowCubit>()
                  .handleFollowButtonTap(userPubKey);
            },
          ),
        ]
      ],
    );
  }
}
