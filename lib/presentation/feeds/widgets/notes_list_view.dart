import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../model/note.dart';
import '../../general/widget/margined_body.dart';
import '../../general/widget/note_card/note_card.dart';
import 'feed_page_heading.dart';

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
  });

  final List<Note> notes;
  final String? feedName;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool hideCount;
  final EdgeInsets? cardMargin;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final nothingToShow = Text(
      'There is nothing here yet.',
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.grey,
          ),
    );

    if (feedName != null) {
      return MarginedBody(
        child: Builder(builder: (context) {
          if (notes.isEmpty) {
            return Column(
              children: <Widget>[
                FeedPageHeading(
                  hideCount: hideCount,
                  feedName: feedName!,
                  notesLength: max(notes.length - 1, 0),
                ),
                const SizedBox(height: 20),
                Center(
                  child: nothingToShow,
                ),
              ],
            );
          }
          return ListView.builder(
            physics: physics,
            shrinkWrap: shrinkWrap,
            controller: scrollController,
            itemCount: notes.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return FeedPageHeading(
                  hideCount: hideCount,
                  feedName: feedName!,
                  notesLength: max(notes.length - 1, 0),
                );
              }
              return NoteCard(
                cardMargin: cardMargin,
                note: notes[index - 1],
              );
            },
          );
        }),
      );
    } else {
      return MarginedBody(
        child: Builder(builder: (context) {
          if (notes.isEmpty) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: nothingToShow,
                ),
              ],
            );
          }
          return ListView.builder(
            physics: physics,
            shrinkWrap: shrinkWrap,
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteCard(
                note: notes[index],
              );
            },
          );
        }),
      );
    }
  }
}
