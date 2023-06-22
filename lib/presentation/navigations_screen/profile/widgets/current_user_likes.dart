import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/liked_note/liked_note_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/note_card/note_card.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/current_user_likes/current_user_likes_cubit.dart';

class CurrentUserLikes extends StatelessWidget {
  const CurrentUserLikes({super.key});

  @override
  Widget build(BuildContext context) {
    final String appCurrentUserPublicKey =
        Nostr.instance.keysService.derivePublicKey(
      privateKey: LocalDatabase.instance.getPrivateKey()!,
    );

    return BlocProvider<CurrentUserLikesCubit>(
      create: (context) => CurrentUserLikesCubit(
        currentUserLikedPosts: NostrService.instance.currentUserLikes(),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CurrentUserLikesCubit, CurrentUserLikesState>(
            builder: (context, profileCubitState) {
              return MarginedBody(
                margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ) +
                    const EdgeInsets.only(top: 25),
                child: ListView.builder(
                  itemCount: profileCubitState.currentUserLikedPosts.length,
                  itemBuilder: (context, index) {
                    final current =
                        profileCubitState.currentUserLikedPosts[index];

                    return BlocProvider<LikedNoteCubit>.value(
                      value: LikedNoteCubit(
                        likedNoteStream: NostrService.instance.noteStreamById(
                          noteId: current.tags.firstWhere(
                            (element) {
                              return element.first.toLowerCase() == "e";
                            },
                          )[1],
                        ),
                      ),
                      child: Builder(
                        builder: (context) {
                          return BlocBuilder<LikedNoteCubit, LikedNoteState>(
                            builder: (context, likedNoteState) {
                              if (likedNoteState.likedNote != null) {
                                return NoteCard(
                                  appCurrentUserPublicKey:
                                      appCurrentUserPublicKey,
                                  note: likedNoteState.likedNote!,
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
