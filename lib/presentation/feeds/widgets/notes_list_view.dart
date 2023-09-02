import 'dart:math';

import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/feeds/widgets/feed_page_heading.dart';
import 'package:ditto/presentation/general/loading_widget.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/note_card/note_card.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:flutter/material.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    required this.notes,
    this.scrollController,
    this.feedName,
    this.physics,
    this.shrinkWrap = false,
    this.hideCount = false,
    this.cardMargin,
    this.endTitleWithAdditionalText = true,
    this.showLoadingIndicator = true,
  });

  final List<Note> notes;
  final String? feedName;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool hideCount;
  final EdgeInsets? cardMargin;
  final ScrollController? scrollController;
  final bool endTitleWithAdditionalText;
  final bool showLoadingIndicator;
  @override
  Widget build(BuildContext context) {
    final String appCurrentUserPublicKey =
        Nostr.instance.keysService.derivePublicKey(
      privateKey: LocalDatabase.instance.getPrivateKey()!,
    );

    final nothingToShow = Text(
      'There is nothing here yet.',
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(color: AppColors.grey),
    );

    notes.sort((a, b) => b.event.createdAt.compareTo(a.event.createdAt));

    if (feedName != null) {
      return MarginedBody(
        child: Builder(
          builder: (context) {
            if (notes.isEmpty) {
              return Column(
                children: <Widget>[
                  FeedPageHeading(
                    endTitleWithAdditionalText: endTitleWithAdditionalText,
                    hideCount: hideCount,
                    feedName: feedName!,
                    notesLength: max(notes.length - 1, 0),
                  ),
                  const SizedBox(height: 20),
                  Center(child: nothingToShow),
                ],
              );
            }
            return ListView.builder(
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              cacheExtent: 10,
              physics: physics,
              shrinkWrap: shrinkWrap,
              controller: scrollController,
              itemCount: notes.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return FeedPageHeading(
                    endTitleWithAdditionalText: endTitleWithAdditionalText,
                    hideCount: hideCount,
                    feedName: feedName!,
                    notesLength: max(notes.length - 1, 0),
                  );
                }
                final current = notes[index - 1];
                return NoteCard(
                  key: ValueKey(current.event.id),
                  appCurrentUserPublicKey: appCurrentUserPublicKey,
                  cardMargin: cardMargin,
                  note: current,
                );
              },
            );
          },
        ),
      );
    } else {
      return MarginedBody(
        child: Builder(
          builder: (context) {
            if (notes.isEmpty) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Center(child: nothingToShow),
                  SizedBox(height: 10),
                  LoadingWidget.minor(isVisible: showLoadingIndicator),
                ],
              );
            }
            return ListView.builder(
              physics: physics,
              shrinkWrap: shrinkWrap,
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final current = notes[index];

                return NoteCard(
                  key: ValueKey(current.event.id),
                  appCurrentUserPublicKey: appCurrentUserPublicKey,
                  note: current,
                );
              },
            );
          },
        ),
      );
    }
  }
}
