import 'package:ditto/constants/strings.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../../buisness_logic/note_comments/note_comments_cubit.dart';
import '../../../constants/colors.dart';

class CommentField extends StatelessWidget {
  const CommentField({
    super.key,
    required this.noteId,
  });

  final String noteId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCommentsCubit>();

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextField(
          controller: cubit.commentTextController,
          decoration: InputDecoration(
            hintText: AppStrings.typeHere,
            hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.black.withOpacity(0.75),
                ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              borderSide: BorderSide.none,
            ),
            fillColor: AppColors.lighGrey,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
          ),
        ),
        Container(
          margin: MarginedBody.defaultMargin,
          child: GestureDetector(
            onTap: () {
              cubit.postComment(noteId);
            },
            child: Icon(
              FlutterRemix.message_2_line,
              color: AppColors.black.withOpacity(0.75),
              size: 19,
            ),
          ),
        ),
      ],
    );
  }
}
