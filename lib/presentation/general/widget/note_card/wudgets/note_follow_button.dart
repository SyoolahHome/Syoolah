import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../model/note.dart';
import '../../../../../services/utils/snackbars.dart';

class NoteFollowButton extends StatelessWidget {
  const NoteFollowButton({
    super.key,
    required this.note,
  });

  final Note note;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GlobalCubit>();
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        final isNoteOwnerFollowed =
            cubit.isNoteOwnerFollowed(note.event.pubkey);

        return SizedBox(
          height: 27.5,
          child: ElevatedButton(
            onPressed: () {
              cubit.handleFollowButtonTap(note.event.pubkey);
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
              isNoteOwnerFollowed ? "unfollow".tr() : "follow".tr(),
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
