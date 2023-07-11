import 'package:ditto/buisness_logic/note_comments/note_comments_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../general/text_field.dart';

class CommentField extends StatelessWidget {
  const CommentField({
    super.key,
    required this.noteId,
  });

  final String noteId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCommentsCubit>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.background,
            width: 0.5,
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10.0),
              CustomTextField(
                controller: cubit.commentTextController,
                hint: "newYourCommentHere".tr(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
          Container(
            margin: MarginedBody.defaultMargin,
            child: IconButton(
              onPressed: () => cubit.postComment(noteId),
              icon: Icon(
                FlutterRemix.send_plane_2_line,
                color: Theme.of(context).colorScheme.background.withOpacity(.6),
                size: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
