import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/feeds/widgets/notes_list_view.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/current_user_posts/current_user_posts_cubit.dart';
import '../../../../constants/abstractions/abstractions.dart';

class CurrentUserPosts extends UserProfileTab {
  CurrentUserPosts({
    super.key,
    required super.userPubKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentUserPostsCubit>(
      create: (context) => CurrentUserPostsCubit(
        currentUserPostsStream: NostrService.instance.subs.userTextNotesStream(
          userPubKey: userPubKey,
        ),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CurrentUserPostsCubit, CurrentUserPostsState>(
            builder: (context, state) {
              List<NostrEvent> currentUserNotes = state.currentUserPosts;
              // currentUserNotes = currentUserNotes.excludeCommentEvents();

              return NotesListView(
                shrinkWrap: true,
                // feedName: "posts".tr(),
                endTitleWithAdditionalText: false,
                showLoadingIndicator: state.shouldShowLoadingIndicator,
                hideCount: true,
                physics: const NeverScrollableScrollPhysics(),
                notes: currentUserNotes.map((e) => Note.fromEvent(e)).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
