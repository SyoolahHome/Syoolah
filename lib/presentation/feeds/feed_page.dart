import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/presentation/feeds/widgets/new_notes_tip.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../model/note.dart';

import 'widgets/app_bar.dart';
import 'widgets/notes_list_view.dart';

class GeneralFeed extends StatelessWidget {
  const GeneralFeed({
    super.key,
    required this.feedName,
    required this.feedPostsStream,
  });

  final String feedName;
  final NostrEventsStream feedPostsStream;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalFeedCubit>(
      create: (context) => GlobalFeedCubit(
        feedPostsStream: feedPostsStream,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            appBar: CustomAppBar(feedName: feedName),
            body: Builder(
              builder: (context) {
                final cubit = context.read<GlobalFeedCubit>();

                return BlocSelector<GlobalFeedCubit, GlobalFeedState,
                    List<Note>>(
                  selector: (state) => state.searchedFeedNotesPosts,
                  builder: (context, notes) {
                    return BlocSelector<GlobalFeedCubit, GlobalFeedState,
                        List<NostrEvent>>(
                      selector: (state) => state.shownFeedPosts,
                      builder: (context, shownFeedPosts) {
                        return NotesListView(
                          scrollController: cubit.scrollController,
                          feedName: feedName,
                          notes: notes.isNotEmpty
                              ? notes
                              : shownFeedPosts
                                  .map((e) => Note.fromEvent(e))
                                  .toList(),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          NewNotesTip(),
        ],
      ),
    );
  }
}
