import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/constants/colors.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostr_client/nostr_client.dart';

import '../../../buisness_logic/note_card_cubit/note_card_cubit.dart';
import '../../../model/note.dart';
import '../../../services/nostr/nostr.dart';
import 'note_avatat_and_name.dart';
import 'note_contents.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCardCubit>.value(
      value: NoteCardCubit(
        note: note,
        currentUserMetadataStream:
            NostrService.instance.userMetadata(note.event.pubkey),
      ),
      child: Builder(builder: (context) {
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
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: MarginedBody.defaultMargin.horizontal / 2,
              vertical: MarginedBody.defaultMargin.horizontal / 4,
            ),
            margin: EdgeInsets.symmetric(
              vertical: MarginedBody.defaultMargin.horizontal / 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.lighGrey,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                NoteAvatarAndName(
                  avatarUrl: noteOwnerMetadata.picture!,
                  nameToShow: noteOwnerMetadata.nameToShow(),
                  dateTimeToShow: note.event.createdAt.toReadableString(),
                ),
                Divider(
                  color: AppColors.grey.withOpacity(0.5),
                ),
                const SizedBox(height: 15),
                NoteContents(
                  heroTag: note.event.createdAt.toString(),
                  imageLinks: note.imageLinks
                      .map(
                        (link) => link,
                      )
                      .toList(),
                  text: note.noteOnly,
                ),
              ],
            ),
          );
        });
      }),
    );
  }
}
