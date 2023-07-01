import 'dart:math' as math;
import 'package:dart_nostr/dart_nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/note_comments/note_comments_cubit.dart';
import '../../general/widget/margined_body.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    required this.noteContents,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  final String noteContents;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: const Icon(FlutterRemix.arrow_left_line),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        '${noteContents.substring(0, math.min(noteContents.length, 15))}...',
      ),
      actions: <Widget>[
        AnimatedSwitcher(
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          duration: const Duration(milliseconds: 300),
          child: BlocSelector<NoteCommentsCubit, NoteCommentsState,
              List<NostrEvent>>(
            selector: (state) => state.noteComments,
            builder: (context, stateCommentsEvents) {
              final commentsLength = stateCommentsEvents.length;

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Text(
                  "$commentsLength",
                  key: ValueKey(commentsLength),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: MarginedBody.defaultMargin.left)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
