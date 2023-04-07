import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/constants/colors.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostr_client/nostr_client.dart';

import '../../../buisness_logic/note_card_cubit/note_card_cubit.dart';
import '../../../model/note.dart';
import '../../../services/nostr/nostr.dart';

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
              NostrService.instance.userMetadata(note.event.pubkey)),
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
              children: <Widget>[
                const SizedBox(height: 10),
                Text(noteOwnerMetadata.name),
                Text(note.event.createdAt.toString()),
                const SizedBox(height: 10),
                Text(
                  note.noteOnly,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: note.imageLinks.map(
                    (link) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: CachedNetworkImage(
                          imageUrl: link,
                          height: 120,
                        ),
                      );
                    },
                  ).toList()),
                ),
              ],
            ),
          );
        });
      }),
    );
  }
}
