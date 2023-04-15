import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/strings.dart';
import '../../../../../model/note.dart';

class NoteFollowButton extends StatelessWidget {
  const NoteFollowButton({
    super.key,
    required this.note,
  });

  final Note note;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        final isNoteOwnerFollowed = state.currentUserFollowing?.tags
                .map((elem) => elem[1])
                .contains(note.event.pubkey) ??
            false;
        return SizedBox(
          height: 27.5,
          child: ElevatedButton(
            onPressed: () {
              final cubit = context.read<GlobalCubit>();

              if (isNoteOwnerFollowed) {
                cubit.unfollowUser(note.event.pubkey);
              } else {
                cubit.followUser(note.event.pubkey);
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              side: BorderSide(
                color:
                    isNoteOwnerFollowed ? AppColors.teal : Colors.transparent,
                width: 1,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              backgroundColor:
                  isNoteOwnerFollowed ? Colors.transparent : AppColors.teal,
            ),
            child: Text(
              isNoteOwnerFollowed ? AppStrings.unfollow : AppStrings.follow,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color:
                        isNoteOwnerFollowed ? AppColors.teal : AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        );
      },
    );
  }
}
