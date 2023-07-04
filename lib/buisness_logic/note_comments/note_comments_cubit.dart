import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'note_comments_state.dart';

/// {@template note_comments_cubit}
/// The responsible cubit about the note/post comments.
/// {@endtemplate}
class NoteCommentsCubit extends Cubit<NoteCommentsState> {
  /// The text field controller to hold the user comment input.
  TextEditingController? commentTextController;

  /// The Nostr stream for the note comments.
  NostrEventsStream noteCommentsStream;

  /// The stream subscription for the [noteCommentsStream.stream].
  StreamSubscription? _noteCommentsStreamSubscription;

  /// {@macro note_comments_cubit}
  NoteCommentsCubit({
    required this.noteCommentsStream,
  }) : super(NoteCommentsState.initial()) {
    _init();
  }

  @override
  Future<void> close() {
    _noteCommentsStreamSubscription?.cancel();

    return super.close();
  }

  // void noteComment({
  //   required String postEventId,
  //   required String text,
  // }) {
  //   NostrService.instance.send.addCommentToPost(
  //     postEventId: postEventId,
  //     text: text,
  //   );
  // }

  /// Sends the comment event with the user's input of [commentTextController].
  /// if the controller is not initialized, it does nothing.
  /// if the controller is empty, it does nothing.
  void postComment(String postEventId) {
    final comment = commentTextController?.text;
    if (comment == null || comment.isEmpty) {
      return;
    }

    NostrService.instance.send.addCommentToPost(
      postEventId: postEventId,
      text: comment,
    );

    commentTextController?.clear();
  }

  void _handleStreams() {
    _noteCommentsStreamSubscription = noteCommentsStream.stream.listen((event) {
      final newCommentsList = <NostrEvent>[
        ...state.noteComments,
        event,
      ];

      emit(state.copyWith(noteComments: newCommentsList));
    });
  }

  void _init() {
    commentTextController = TextEditingController();
    _handleStreams();
  }
}
