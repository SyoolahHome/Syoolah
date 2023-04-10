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
                    itemCount: state.feedPosts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Text(
                                AppStrings.feedOfName(feedName),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.teal.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: AnimatedSwitcher(
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    state.feedPosts.length.toString(),
                                    key: ValueKey(state.feedPosts.length),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: AppColors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return NoteCard(
                        note: Note.fromEvent(
                          state.feedPosts[index - 1],
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
