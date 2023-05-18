import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class NewNotesTip extends StatelessWidget {
  const NewNotesTip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalFeedCubit, GlobalFeedState>(
      builder: (context, state) {
        final generalP = state.feedPosts.length;
        final shownP = state.shownFeedPosts.length;
        int newTweets = generalP - shownP;
        final isThereNewPosts = newTweets > 0;
        final mq = MediaQuery.of(context);

        return Animate(
          target: isThereNewPosts ? 1 : 0,
          effects: const [
            FadeEffect(begin: 0, end: 1),
            ScaleEffect(begin: Offset(0.5, 0.5), end: Offset(1, 1)),
          ],
          child: Container(
            margin: EdgeInsets.only(top: mq.padding.top + kToolbarHeight),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background,
                foregroundColor: Theme.of(context).colorScheme.onBackground,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              onPressed: () {
                context.read<GlobalFeedCubit>().goTop();
                context.read<GlobalFeedCubit>().showNewestPostsToUI();
              },
              label: Animate(
                key: ValueKey<int>(newTweets),
                effects: [FadeEffect(duration: 50.ms)],
                child: Text("New $newTweets Notes"),
              ),
              icon: const Icon(
                FlutterRemix.arrow_up_line,
                size: 19,
              ),
            ),
          ),
        );
      },
    );
  }
}
