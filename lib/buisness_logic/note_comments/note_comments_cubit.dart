import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../services/nostr/nostr.dart';

part 'note_comments_state.dart';

class NoteCommentsCubit extends Cubit<NoteCommentsState> {
  Stream<NostrEvent> noteCommentsStream;
  StreamSubscription? _noteCommentsStreamSubscription;
  TextEditingController? commentTextController;

  NoteCommentsCubit({
    required this.noteCommentsStream,
  }) : super(NoteCommentsInitial()) {
    commentTextController = TextEditingController();
    _handleStreams();
  }

  void _handleStreams() {
    _noteCommentsStreamSubscription = noteCommentsStream.listen((event) {
      emit(state.copyWith(noteComments: [...state.noteComments, event]));
    });
  }

  @override
  Future<void> close() {
    _noteCommentsStreamSubscription!.cancel();
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
    NostrService.instance.addCommentToPost(
      postEventId: postEventId,
      text: commentTextController!.text,
    );
    commentTextController!.clear();
  }
}
