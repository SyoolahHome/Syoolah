import 'package:dart_nostr/dart_nostr.dart';
import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/current_user_comments/current_user_comments_cubit.dart';
import '../../../../constants/abstractions/abstractions.dart';
import '../../../../constants/app_colors.dart';
import '../../../../model/note.dart';
import '../../../feeds/widgets/notes_list_view.dart';

class CurrentUserComments extends UserProfileTab {
  CurrentUserComments({
    super.key,
    required super.userPubKey,
  });

  @override
  Widget build(BuildContext context) {
    final String appCurrentUserPublicKey =
        Nostr.instance.keysService.derivePublicKey(
      privateKey: LocalDatabase.instance.getPrivateKey()!,
    );

    final nothingToShow = Text(
      'There is nothing here yet.',
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.grey,
          ),
    );

    return BlocProvider<CurrentUserCommentsCubit>(
      create: (context) => CurrentUserCommentsCubit(
        currentUserCommentsStream: NostrService.instance.subs.userComments(
          userPubKey: userPubKey,
        ),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CurrentUserCommentsCubit,
              CurrentUserCommentsState>(
            builder: (context, state) {
              List<NostrEvent> currentUserComments = state.currentUserComments;
              // currentUserNotes = currentUserNotes.excludeCommentEvents();

              return NotesListView(
                shrinkWrap: true,
                // feedName: "posts".tr(),
                endTitleWithAdditionalText: false,
                showLoadingIndicator: state.shouldShowLoadingIndicator,
                hideCount: true,
                physics: const NeverScrollableScrollPhysics(),
                onlyCommentNotes: true,
                notes:
                    currentUserComments.map((e) => Note.fromEvent(e)).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
