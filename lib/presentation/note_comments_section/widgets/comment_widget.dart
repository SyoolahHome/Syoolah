import 'package:dart_nostr/nostr/model/event.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_owner_avatar.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_vreation_ago.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: index % 2 == 0
          ? AppColors.lighGrey.withOpacity(.45)
          : Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 7.5,
          vertical: 5,
        ),
        title: Text(
          commentEvent.content.capitalized,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        leading: const NoteOwnerAvatar(
          size: 25,
          avatarUrl: "https://placeholder.com/100x100?color=blue",
        ),
        trailing: GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NoteDateOfCreationAgo(
                createdAt: commentEvent.createdAt,
                isSmall: true,
              ),
              const SizedBox(width: 5.0),
              const Icon(
                FlutterRemix.more_2_line,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
