import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteFollowButton extends StatelessWidget {
  const NoteFollowButton({
    super.key,
    required this.userPubLickKey,
  });

  final String? userPubLickKey;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GlobalCubit>();

    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        final isNoteOwnerFollowed = userPubLickKey != null
            ? cubit.isNoteOwnerFollowed(userPubLickKey!)
            : false;

        return SizedBox(
          height: 27.5,
          child: RoundaboutButton(
            onTap: () {
              if (userPubLickKey != null) {
                cubit.handleFollowButtonTap(userPubLickKey!);
              }
            },
            isOnlyBorder: isNoteOwnerFollowed,
            isSmall: true,
            text: isNoteOwnerFollowed ? "unfollow".tr() : "follow".tr(),
          ),
        );
      },
    );
  }
}
