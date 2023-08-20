import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/liked_note/liked_note_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/note_card/note_card.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/current_user_likes/current_user_likes_cubit.dart';
import '../../../../constants/abstractions/abstractions.dart';
import '../../../../constants/app_colors.dart';
import '../../../general/loading_widget.dart';

class CurrentUserLikes extends UserProfileTab {
  CurrentUserLikes({
    super.key,
    required super.userPubKey,
  });

  @override
  Widget build(BuildContext context) {
    final String appCurrentUserPublicKey =
        Nostr.instance.keysService.derivePublicKey(
      privateKey: LocalDatabase.instance.getPrivateKey()!,
    );

    final nothingToShow = Text(
      'There is nothing here yet.',
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.grey,
          ),
    );

    return BlocProvider<CurrentUserLikesCubit>(
      create: (context) => CurrentUserLikesCubit(
        currentUserLikedPosts: NostrService.instance.subs.userLikes(
          userPubKey: userPubKey,
        ),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CurrentUserLikesCubit, CurrentUserLikesState>(
            builder: (context, profileCubitState) {
              return MarginedBody(
                margin: const EdgeInsets.symmetric(horizontal: 16) +
                    const EdgeInsets.only(top: 20),
                child: profileCubitState.currentUserLikedPosts.isNotEmpty
                    ? ListView.builder(
                        itemCount:
                            profileCubitState.currentUserLikedPosts.length,
                        itemBuilder: (context, index) {
                          final current =
                              profileCubitState.currentUserLikedPosts[index];

                          return BlocProvider<LikedNoteCubit>.value(
                            value: LikedNoteCubit(
                              likedNoteStream:
                                  NostrService.instance.subs.noteStreamById(
                                noteId: current.tags.firstWhere(
                                  (element) {
                                    return element.first.toLowerCase() == "e";
                                  },
                                )[1],
                              ),
                            ),
                            child: Builder(
                              builder: (context) {
                                return BlocBuilder<LikedNoteCubit,
                                    LikedNoteState>(
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
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(child: nothingToShow),
                          SizedBox(height: 10),
                          BlocSelector<CurrentUserLikesCubit,
                              CurrentUserLikesState, bool>(
                            selector: (state) {
                              return state.shouldShowLoadingIndicator;
                            },
                            builder: (context, shouldShowLoadingIndicator) {
                              return LoadingWidget.minor(
                                isVisible: shouldShowLoadingIndicator,
                              );
                            },
                          ),
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
