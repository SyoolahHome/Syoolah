import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../model/note.dart';

import '../../services/utils/routing.dart';
import '../general/widget/note_card/note_card.dart';
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
      create: (context) => Routing.feedCubit(
        feedPostsStream: feedPostsStream,
      ),
      child: Scaffold(
        appBar: CustomAppBar(feedName: feedName),
        body: Builder(
          builder: (context) {
            return BlocBuilder<FeedCubit, GlobalFeedState>(
              builder: (context, state) {
                if (state.searchedFeedNotesPosts.isNotEmpty) {
                  return NotesListView(
                    feedName: feedName,
                    notes: state.searchedFeedNotesPosts,
                  );
                } else {
                  return NotesListView(
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
