import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/feeds/widgets/app_bar.dart';
import 'package:ditto/presentation/feeds/widgets/new_notes_tip.dart';
import 'package:ditto/presentation/feeds/widgets/notes_list_view.dart';
import 'package:ditto/presentation/general/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            drawer: CustomDrawer(),
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
          const NewNotesTip(),
        ],
      ),
    );
  }
}
