import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/constants/colors.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/note_card_cubit/note_card_cubit.dart';
import '../../../../model/note.dart';
import '../../../../services/nostr/nostr.dart';
import '../../../home/widgets/or_divider.dart';
import '../margined_body.dart';
import 'wudgets/note_actions.dart';
import 'wudgets/note_avatat_and_name.dart';
import 'wudgets/note_bg.dart';
import 'wudgets/note_contents.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCardCubit>(
      create: (context) => NoteCardCubit(
        note: note,
        currentUserMetadataStream:
            NostrService.instance.userMetadata(note.event.pubkey),
        noteLikesStream: NostrService.instance.noteLikes(
          postEventId: note.event.id,
        ),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<NoteCardCubit, NoteCardState>(
            builder: (context, state) {
              UserMetaData noteOwnerMetadata;

              if (state.noteOwnerMetadata == null) {
                noteOwnerMetadata = UserMetaData.placeholder();
              } else {
                noteOwnerMetadata = UserMetaData.fromJson(
                  jsonDecode(state.noteOwnerMetadata!.content)
                      as Map<String, dynamic>,
                );
              }

              return NoteContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    NoteAvatarAndName(
                      avatarUrl: noteOwnerMetadata.picture!,
                      nameToShow: noteOwnerMetadata.nameToShow(),
                    ),
                    const OrDivider(onlyDivider: true),
                    NoteContents(
                      heroTag: note.event.uniqueTag(),
                      imageLinks: note.imageLinks,
                      text: note.noteOnly,
                    ),
                    NoteActions(note: note),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
