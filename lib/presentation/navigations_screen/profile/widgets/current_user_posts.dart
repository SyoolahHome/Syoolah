import 'package:ditto/buisness_logic/cubit/current_user_posts_cubit.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/feeds/widgets/notes_list_view.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserPosts extends StatelessWidget {
  const CurrentUserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentUserPostsCubit>(
      create: (context) => CurrentUserPostsCubit(
        currentUserPostsStream:
            NostrService.instance.currentUserTextNotesStream(),
      ),
      child: Builder(builder: (context) {
        return BlocBuilder<CurrentUserPostsCubit, CurrentUserPostsState>(
          builder: (context, state) {
            return NotesListView(
              shrinkWrap: true,
              feedName: "myPosts".tr(),
              hideCount: true,
              physics: const NeverScrollableScrollPhysics(),
              notes:
                  state.currentUserPosts.map((e) => Note.fromEvent(e)).toList(),
            );
          },
        );
      },),
    );
  }
}
