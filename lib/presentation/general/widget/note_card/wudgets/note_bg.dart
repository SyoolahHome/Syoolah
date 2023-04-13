import 'package:ditto/buisness_logic/feed_box/feed_box_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/colors.dart';
import '../../margined_body.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    super.key,
    required this.child,
  });

  final Widget child;
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: MarginedBody.defaultMargin.horizontal / 2,
                  vertical: MarginedBody.defaultMargin.horizontal / 4,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: MarginedBody.defaultMargin.horizontal / 4,
                ),
                decoration: BoxDecoration(
                  color: state.isHighlighted
                      ? AppColors.lighGrey.withOpacity(0.5)
                      : AppColors.lighGrey,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: child,
              ),
            );
          },
        );
      }),
    );
  }
}
