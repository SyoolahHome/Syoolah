import 'package:ditto/buisness_logic/note_card_cubit/note_card_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/note_comments/note_comments_cubit.dart';
import '../../model/note.dart';
import '../../services/nostr/nostr_service.dart';
import 'widgets/comment_field.dart';
import 'widgets/comment_widget.dart';

class NoteCommentsSection extends StatelessWidget {
  NoteCommentsSection({
    super.key,
  });

  Note? note;
  NoteCardCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    note = args['note'] as Note;
    cubit = args['cubit'] as NoteCardCubit;
    final id = note!.event.id;

    return BlocProvider<NoteCardCubit>.value(
      value: cubit!,
      child: BlocProvider<NoteCommentsCubit>(
        create: (context) => NoteCommentsCubit(
          noteCommentsStream: NostrService.instance.noteComments(
            note: note!,
            postEventId: id,
          ),
        ),
        child: Builder(builder: (context) {
          final cubit = context.read<NoteCommentsCubit>();

          return Center(
            child: BlocBuilder<NoteCommentsCubit, NoteCommentsState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    iconTheme: const IconThemeData(color: AppColors.white),
                    centerTitle: true,
                    title: Text(
                      "commentsN".tr(args: [
                        "comments".tr(),
                        state.noteComments.length.toString()
                      ]),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.white,
                          ),
                    ),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.noteComments.length,
                          itemBuilder: (context, index) {
                            final current = state.noteComments[index];
                            return CommentWidget(
                              commentEvent: current,
                              index: index,
                            );
                            return ListTile(
                              title: Text(current.content),
                              subtitle: Text(current.pubkey),
                            );
                          },
                        ),
                      ),
                      CommentField(noteId: note!.event.id),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
