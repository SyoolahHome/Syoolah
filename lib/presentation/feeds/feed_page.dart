import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../model/note.dart';

import '../../services/utils/routing.dart';
import 'widgets/app_bar.dart';
import 'widgets/notes_list_view.dart';

class GeneralFeed extends StatelessWidget {
  const GeneralFeed({
    super.key,
    required this.feedName,
    required this.feedPostsStream,
  });

  final String feedName;
  final Stream<NostrEvent> feedPostsStream;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedCubit>(
      create: (context) => FeedCubit(feedPostsStream: feedPostsStream),
      child: Scaffold(
        appBar: CustomAppBar(feedName: feedName),
        floatingActionButton: BlocBuilder<FeedCubit, GlobalFeedState>(
          builder: (context, state) {
            return AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: state.shouldShowScrollToTopButton ? 1 : 0,
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(FlutterRemix.arrow_up_s_line),
              ),
            );
          },
        ),
        body: Builder(
          builder: (context) {
            final cubit = context.read<FeedCubit>();

            return BlocBuilder<FeedCubit, GlobalFeedState>(
              builder: (context, state) {
                if (state.searchedFeedNotesPosts.isNotEmpty) {
                  return NotesListView(
                    scrollController: cubit.scrollController,
                    feedName: feedName,
                    notes: state.searchedFeedNotesPosts,
                  );
                } else {
                  return NotesListView(
                    scrollController: cubit.scrollController,
                    feedName: feedName,
                    notes:
                        state.feedPosts.map((e) => Note.fromEvent(e)).toList(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
