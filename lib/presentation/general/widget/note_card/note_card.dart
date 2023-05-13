import 'dart:convert';
import 'package:ditto/model/user_meta_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/note_card_cubit/note_card_cubit.dart';
import '../../../../model/note.dart';
import '../../../../services/nostr/nostr_service.dart';
import 'wudgets/note_actions.dart';
import 'wudgets/note_avatat_and_name.dart';
import 'wudgets/note_bg.dart';
import 'wudgets/note_contents.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.cardMargin,
    required this.appCurrentUserPublicKey,
  });

  final Note note;
  final EdgeInsets? cardMargin;
  final String appCurrentUserPublicKey;
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
            key: ValueKey(note.event.uniqueTag()),
            builder: (context, state) {
              UserMetaData noteOwnerMetadata;

              if (state.noteOwnerMetadata == null) {
                noteOwnerMetadata = UserMetaData.placeholder(name: "No Name");
              } else {
                noteOwnerMetadata = UserMetaData.fromJson(
                  jsonDecode(state.noteOwnerMetadata!.content)
                      as Map<String, dynamic>,
                );
              }

              return NoteContainer(
                key: ValueKey(note.event.uniqueTag()),
                note: note,
                margin: cardMargin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    NoteAvatarAndName(
                      appCurrentUserPublicKey: appCurrentUserPublicKey,
                      userPubKey: state.noteOwnerMetadata?.pubkey ?? "",
                      note: note,
                      avatarUrl: noteOwnerMetadata.picture!,
                      nameToShow: noteOwnerMetadata.nameToShow(),
                      memeberShipStartedAt:
                          state.noteOwnerMetadata?.createdAt ??
                              note.event.createdAt,
                    ),
                    const SizedBox(height: 10),
                    NoteContents(
                      youtubeVideosLinks: note.youtubeVideoLinks,
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
