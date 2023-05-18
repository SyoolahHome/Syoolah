import 'package:ditto/buisness_logic/feed_box/feed_box_cubit.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    super.key,
    required this.child,
    required this.note,
    this.margin,
  });

  final Widget child;
  final EdgeInsets? margin;
  final Note note;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBoxCubit>(
      create: (context) => FeedBoxCubit(),
      child: Builder(builder: (context) {
        final feedBoxCubit = context.read<FeedBoxCubit>();
        return BlocBuilder<FeedBoxCubit, FeedBoxState>(
          builder: (context, state) {
            return GestureDetector(
              onPanDown: (details) {
                feedBoxCubit.highlightBox();
              },
              onPanCancel: () {
                feedBoxCubit.unHighlightBox();
              },
              onPanEnd: (details) {
                feedBoxCubit.unHighlightBox();
              },
              onPanStart: (details) {
                feedBoxCubit.highlightBox();
              },
              onLongPress: () {
                feedBoxCubit.showOptions(context,
                    note: note, onCommentsSectionTapped: () {},);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: MarginedBody.defaultMargin.horizontal / 2,
                  vertical: MarginedBody.defaultMargin.horizontal / 4,
                ),
                margin: margin ??
                    EdgeInsets.only(
                      bottom: MarginedBody.defaultMargin.horizontal / 2,
                    ),
                decoration: BoxDecoration(
                  color: state.isHighlighted
                      ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)
                      : Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.6),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: child,
              ),
            );
          },
        );
      },),
    );
  }
}
