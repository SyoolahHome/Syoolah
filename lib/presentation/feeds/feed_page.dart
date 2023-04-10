import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostr_client/nostr/model/event.dart';

import '../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../constants/strings.dart';
import '../../model/note.dart';
import '../../services/nostr/nostr.dart';
import '../../services/utils/routing.dart';
import '../general/widget/post_card.dart';
import 'widgets/app_bar.dart';

class GeneralFeed extends StatelessWidget {
  const GeneralFeed(
      {super.key, required this.feedName, required this.feedPostsStream});

  final String feedName;
  final Stream<NostrEvent> feedPostsStream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(feedName: feedName),
      body: BlocProvider<FeedCubit>(
        create: (context) => Routing.feedCubit(
          feedPostsStream: feedPostsStream,
        ),
        child: Builder(
          builder: (context) {
            return BlocBuilder<FeedCubit, GlobalFeedState>(
              builder: (context, state) {
                return MarginedBody(
                  child: ListView.builder(
                    itemCount: state.feedPosts.length,
                    itemBuilder: (context, index) {
                      return NoteCard(
                        note: Note.fromEvent(
                          state.feedPosts[index],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
