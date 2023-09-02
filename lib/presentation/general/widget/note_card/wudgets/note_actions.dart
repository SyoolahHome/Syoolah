import 'package:ditto/buisness_logic/feed_box/feed_box_cubit.dart';
import 'package:ditto/buisness_logic/note_card_cubit/note_card_cubit.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_vreation_ago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../../constants/app_colors.dart';

class NoteActions extends StatelessWidget {
  const NoteActions({
    super.key,
    required this.note,
    // required this.avatarUrl,
    // required this.nameToShow,
    // required this.appCurrentUserPublicKey,
    // required this.noteOwnerUserPubKey,
    required this.onCommentsIconClicked,
    this.isComment = false,
  });

  final Note note;
//
//   final String? avatarUrl;
//   final String? nameToShow;
//   final String? appCurrentUserPublicKey;
//   final String? noteOwnerUserPubKey;
  final VoidCallback onCommentsIconClicked;
  final bool isComment;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCardCubit>();

    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            NoteDateOfCreationAgo(
              createdAt: note.event.createdAt,
              isMedium: true,
            ),
            if (!isComment)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BlocBuilder<NoteCardCubit, NoteCardState>(
                    builder: (context, state) {
                      final noteLikes = state.noteLikes;
                      int likes = noteLikes.length;
                      // // if (state.localLiked)l,  {
                      // //   likes += 1;
                      // // }

                      return Action(
                        icon: FlutterRemix.heart_2_fill,
                        onTap: () {
                          if (!cubit.isUserAlreadyLiked()) {
                            cubit.likeNote();
                          }
                        },
                        bgColor: state.localLiked || cubit.isUserAlreadyLiked()
                            ? AppColors.red.withOpacity(.1)
                            : Theme.of(context).colorScheme.onPrimary,
                        color: state.localLiked || cubit.isUserAlreadyLiked()
                            ? AppColors.red
                            : DefaultTextStyle.of(context).style.color!,
                        text: likes.toString(),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<NoteCardCubit, NoteCardState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: Animate.defaultDuration,
                        child: Action(
                          key: ValueKey(state.markAsReposted),
                          icon: state.markAsReposted
                              ? FlutterRemix.check_line
                              : FlutterRemix.repeat_2_line,
                          onTap: () {
                            cubit.repostNote();
                          },
                          bgColor: state.markAsReposted
                              ? Colors.green.withOpacity(.1)
                              : Theme.of(context).colorScheme.onPrimary,
                          color: state.markAsReposted
                              ? Colors.green
                              : DefaultTextStyle.of(context).style.color!,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<NoteCardCubit, NoteCardState>(
                    builder: (context, state) {
                      return Action(
                        icon: FlutterRemix.chat_1_line,
                        onTap: onCommentsIconClicked,
                        bgColor: Theme.of(context).colorScheme.onPrimary,
                        color: DefaultTextStyle.of(context).style.color!,
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<NoteCardCubit, NoteCardState>(
                    builder: (context, state) {
                      return Action(
                        icon: FlutterRemix.more_line,
                        onTap: () {
                          context.read<FeedBoxCubit>().showOptions(
                                context,
                                note: note,
                                onCommentsSectionTapped: () {},
                              );
                        },
                        bgColor: Theme.of(context).colorScheme.onPrimary,
                        color: DefaultTextStyle.of(context).style.color!,
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Action extends StatelessWidget {
  const Action({
    super.key,
    required this.onTap,
    required this.bgColor,
    required this.color,
    this.text,
    required this.icon,
  });

  final void Function() onTap;
  final Color bgColor;
  final Color color;
  final String? text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 25,
            height: 25,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 12.5,
                color: color,
              ),
            ),
          ),
        ),
        if (text != null) ...[
          const SizedBox(width: 1.5),
          Text(
            text!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                ),
          ),
        ]
      ],
    );
  }
}
