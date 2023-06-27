import 'package:ditto/buisness_logic/note_card_cubit/note_card_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/note_comments/note_comments_cubit.dart';
import '../../model/note.dart';
import '../../services/nostr/nostr_service.dart';
import '../general/widget/title.dart';
import 'widgets/app_bar.dart';
import 'widgets/comment_field.dart';
import 'widgets/comment_widget.dart';
import 'widgets/placeholder_card.dart';

class NoteCommentsSection extends StatelessWidget {
  NoteCommentsSection({
    super.key,
  });

  Note? note;

  NoteCardCubit? cubit;

  String? avatarUrl;
  String? nameToShow;
  String? appCurrentUserPublicKey;
  String? noteOwnerUserPubKey;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    note = args['note'] as Note;
    cubit = args['cubit'] as NoteCardCubit;

    avatarUrl = args['avatarUrl'] as String;
    nameToShow = args['nameToShow'] as String;
    appCurrentUserPublicKey = args['appCurrentUserPublicKey'] as String;
    noteOwnerUserPubKey = args['noteOwnerUserPubKey'] as String;

    final id = note!.event.id;

    return BlocProvider<NoteCardCubit>.value(
      value: cubit!,
      child: BlocProvider<NoteCommentsCubit>(
        create: (context) => NoteCommentsCubit(
          noteCommentsStream: NostrService.instance.subs.noteComments(
            note: note!,
            postEventId: id,
          ),
        ),
        child: Builder(
          builder: (context) {
            final cubit = context.read<NoteCommentsCubit>();

            return Center(
              child: BlocBuilder<NoteCommentsCubit, NoteCommentsState>(
                builder: (context, state) {
                  return Scaffold(
                    appBar: CustomAppBar(noteContents: note!.noteOnly),
                    body: MarginedBody(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          NotePlaceholderCard(
                            note: note!,
                            avatarUrl: avatarUrl!,
                            nameToShow: nameToShow!,
                            appCurrentUserPublicKey: appCurrentUserPublicKey!,
                            noteOwnerUserPubKey: noteOwnerUserPubKey!,
                          ),
                          const SizedBox(height: 15),
                          HeadTitle(
                            title: "comments".tr(),
                            isForSection: true,
                            minimizeFontSizeBy: 10.0,
                          ),
                          const SizedBox(height: 10.0),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.noteComments.length,
                              itemBuilder: (BuildContext context, int index) {
                                final current = state.noteComments[index];

                                return CommentWidget(
                                  commentEvent: current,
                                  index: index,
                                );
                              },
                            ),
                          ),
                          CommentField(noteId: note!.event.id),
                          SizedBox(height: MarginedBody.defaultMargin.left),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
