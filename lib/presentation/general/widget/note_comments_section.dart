import 'dart:math';

import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostr_client/nostr_client.dart';

import '../../../buisness_logic/note_comments/note_comments_cubit.dart';
import '../../../model/note.dart';
import '../../../services/nostr/nostr.dart';

class NoteCommentsSection extends StatelessWidget {
  const NoteCommentsSection({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    final id = note.event.id;
    return BlocProvider<NoteCommentsCubit>.value(
      value: NoteCommentsCubit(
        noteCommentsStream: NostrService.instance.noteComments(
          note: note,
          postEventId: id,
        ),
      ),
      child: Builder(builder: (context) {
        final cubit = context.read<NoteCommentsCubit>();

        return Scaffold(
          body: BlocBuilder<NoteCommentsCubit, NoteCommentsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      AppStrings.commentsN(state.noteComments.length),
                    ),
                    Column(
                      children: [
                        ...state.noteComments.map(
                          (e) => Text(e.content),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print("test comment button pressed");

                        cubit.noteComment(
                          postEventId: id,
                          text: "random comment ${Random().nextInt(1000000)}",
                        );
                      },
                      child: const Text("test comment"),
                    )
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
