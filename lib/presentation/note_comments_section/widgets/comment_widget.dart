import 'package:dart_nostr/nostr/model/event.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_vreation_ago.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/comment/comment_cubit.dart';
import '../../general/widget/note_card/wudgets/note_owner_avatar.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.commentEvent,
    required this.index,
  });

  final NostrEvent commentEvent;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentWidgetCubit>(
      create: (context) => CommentWidgetCubit(commentEvent: commentEvent),
      child: BlocBuilder<CommentWidgetCubit, CommentState>(
        builder: (context, state) {
          final commentOwnerPlaceholderMetadata =
              UserMetaData.placeholder(name: "No Name");

          final ownerMetadata =
              state.commentOwnerMetadata ?? commentOwnerPlaceholderMetadata;

          return ClipRRect(
            borderRadius: BorderRadius.circular(7.5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: index % 2 == 0
                  ? Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(.45)
                  : Colors.transparent,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 7.5,
                  vertical: 5,
                ),
                title: Text(
                  ownerMetadata.nameToShow(),
                ),
                subtitle: Text(
                  commentEvent.content.capitalized,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                leading: NoteOwnerAvatar(
                  size: 25,
                  avatarUrl: ownerMetadata.picture ??
                      commentOwnerPlaceholderMetadata.picture!,
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      NoteDateOfCreationAgo(
                        createdAt: commentEvent.createdAt,
                        isSmall: true,
                      ),
                      const SizedBox(width: 5.0),
                      Icon(
                        FlutterRemix.more_2_line,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
