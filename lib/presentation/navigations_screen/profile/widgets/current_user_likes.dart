import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/liked_note/liked_note_cubit.dart';
import '../../../general/widget/margined_body.dart';
import '../../../general/widget/note_card/note_card.dart';

class CurrentUserLikes extends StatelessWidget {
  const CurrentUserLikes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileCubitState) {
        return MarginedBody(
          margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ) +
              const EdgeInsets.only(top: 25),
          child: ListView.builder(
            itemCount: profileCubitState.currentUserLikedPosts.length,
            itemBuilder: (context, index) {
              final current = profileCubitState.currentUserLikedPosts[index];

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
                            note: likedNoteState.likedNote!,
                          );
                        } else {
                          return Text(
                              "likes note of like with id: ${current.id} is not got yet");
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
  }
}
