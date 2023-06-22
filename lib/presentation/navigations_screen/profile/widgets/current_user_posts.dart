import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/feeds/widgets/notes_list_view.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/current_user_posts/current_user_posts_cubit.dart';

class CurrentUserPosts extends StatelessWidget {
  const CurrentUserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentUserPostsCubit>(
      create: (context) => CurrentUserPostsCubit(
        currentUserPostsStream:
            NostrService.instance.currentUserTextNotesStream(),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CurrentUserPostsCubit, CurrentUserPostsState>(
            builder: (context, state) {
              List<NostrEvent> currentUserNotes = state.currentUserPosts;
              currentUserNotes = currentUserNotes.excludeCommentEvents();

              return NotesListView(
                shrinkWrap: true,
                feedName: "posts".tr(),
                endTitleWithAdditionalText: false,
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
