import 'dart:convert';

import 'package:ditto/buisness_logic/note_card_cubit/note_card_cubit.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_actions.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_avatat_and_name.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_bg.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_contents.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/utils/paths.dart';

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
    return Hero(
      tag: note.event.uniqueTag(),
      child: BlocProvider<NoteCardCubit>(
        create: (context) => NoteCardCubit(
          note: note,
          currentUserMetadataStream:
              NostrService.instance.subs.userMetadata(note.event.pubkey),
          noteLikesStream: NostrService.instance.subs.noteLikes(
            postEventId: note.event.id,
          ),
        ),
        child: Builder(
          builder: (context) {
            return BlocBuilder<NoteCardCubit, NoteCardState>(
              builder: (context, state) {
                UserMetaData noteOwnerMetadata;

                if (state.noteOwnerMetadata == null) {
                  noteOwnerMetadata = UserMetaData.placeholder(name: "No Name");
                } else {
                  noteOwnerMetadata = UserMetaData.fromJson(
                    jsonData: jsonDecode(state.noteOwnerMetadata!.content)
                        as Map<String, dynamic>,
                    sourceNostrEvent: state.noteOwnerMetadata!,
                  );
                }

                void onCommentsIconClicked() {
                  Navigator.of(context).pushNamed(
                    Paths.commentsSection,
                    arguments: <String, dynamic>{
                      'note': note,
                      'cubit': context.read<NoteCardCubit>(),
                      'avatarUrl': noteOwnerMetadata.picture,
                      'nameToShow': noteOwnerMetadata.nameToShow(),
                      'appCurrentUserPublicKey': appCurrentUserPublicKey,
                      'noteOwnerUserPubKey': state.noteOwnerMetadata?.pubkey,
                    },
                  );
                }

                return NoteContainer(
                  key: ValueKey(note.event.uniqueTag()),
                  note: note,
                  margin: cardMargin,
                  onTap: onCommentsIconClicked,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      NoteAvatarAndName(
                        userPubKey: state.noteOwnerMetadata?.pubkey ?? "",
                        note: note,
                        appCurrentUserPublicKey: appCurrentUserPublicKey,
                        avatarUrl: noteOwnerMetadata.picture!,
                        nameToShow: noteOwnerMetadata.nameToShow(),
                        memeberShipStartedAt:
                            state.noteOwnerMetadata?.createdAt ??
                                note.event.createdAt,
                      ),
                      const SizedBox(height: 15),
                      NoteContents(
                        youtubeVideosLinks: note.youtubeVideoLinks,
                        heroTag: note.event.uniqueTag(),
                        imageLinks: note.imageLinks,
                        text: note.noteOnly,
                      ),
                      NoteActions(
                        note: note,
                        onCommentsIconClicked: onCommentsIconClicked,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
