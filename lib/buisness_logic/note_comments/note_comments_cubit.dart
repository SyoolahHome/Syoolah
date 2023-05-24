import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'note_comments_state.dart';

class NoteCommentsCubit extends Cubit<NoteCommentsState> {
  TextEditingController? commentTextController;
  NostrEventsStream noteCommentsStream;
  StreamSubscription? _noteCommentsStreamSubscription;

  NoteCommentsCubit({
    required this.noteCommentsStream,
  }) : super(NoteCommentsInitial()) {
    commentTextController = TextEditingController();
    _handleStreams();
  }

  @override
  Future<void> close() {
    _noteCommentsStreamSubscription?.cancel();

    return super.close();
  }

  void noteComment({
    required String postEventId,
    required String text,
  }) {
    NostrService.instance.addCommentToPost(
      postEventId: postEventId,
      text: text,
    );
  }

  void postComment(String postEventId) {
    final comment = commentTextController?.text;
    if (comment == null || comment.isEmpty) {
      return;
    }

    NostrService.instance.addCommentToPost(
      postEventId: postEventId,
      text: comment,
    );
    commentTextController?.clear();
  }

  void _handleStreams() {
    _noteCommentsStreamSubscription = noteCommentsStream.stream.listen((event) {
      emit(state.copyWith(noteComments: [...state.noteComments, event]));
    });
  }
}
