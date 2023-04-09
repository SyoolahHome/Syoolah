import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/note_card_cubit/note_card_cubit.dart';
import '../../../constants/colors.dart';
import '../../../model/note.dart';
import '../../../services/bottom_sheet/bottom_sheet.dart';
import 'note_comments_section.dart';

class NoteActions extends StatelessWidget {
  const NoteActions({
    super.key,
    required this.note,
  });

  final Note note;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCardCubit>();

    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<NoteCardCubit, NoteCardState>(
              builder: (context, state) {
                return Action(
                  icon: FlutterRemix.chat_1_line,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: cubit,
                          child: NoteCommentsSection(
                            note: note,
                          ),
                        ),
                      ),
                    );
                  },
                  bgColor: AppColors.grey.withOpacity(.2),
                  color: AppColors.black,
                  text: 10.toString(),
                );
              },
            ),
            const SizedBox(width: 15),
            BlocBuilder<NoteCardCubit, NoteCardState>(
              builder: (context, state) {
                final noteLikes = state.noteLikes;
                int likes = noteLikes.length;
                if (state.localLiked) {
                  likes += 1;
                }

                return Action(
                  icon: FlutterRemix.heart_2_fill,
                  onTap: () {
                    if (!cubit.isUserAlreadyLiked()) {
                      cubit.likeNote();
                    }
                  },
                  bgColor: state.localLiked || cubit.isUserAlreadyLiked()
                      ? Colors.red.withOpacity(.1)
                      : AppColors.grey.withOpacity(.2),
                  color: state.localLiked || cubit.isUserAlreadyLiked()
                      ? Colors.red
                      : AppColors.black,
                  text: likes.toString(),
                );
              },
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
    required this.text,
    required this.icon,
  });

  final void Function() onTap;
  final Color bgColor;
  final Color color;
  final String text;
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
            width: 35,
            height: 35,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 15,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(width: 2.5),
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
              ),
        ),
      ],
    );
  }
}
