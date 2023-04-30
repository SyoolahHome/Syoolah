import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

import '../../model/note.dart';

part 'liked_note_state.dart';

class LikedNoteCubit extends Cubit<LikedNoteState> {
  Stream<NostrEvent> likedNoteStream;
  StreamSubscription<NostrEvent>? _likedNoteSubscription;

  LikedNoteCubit({
    required this.likedNoteStream,
  }) : super(LikedNoteInitial()) {
    _handleStreams();
  }

  @override
  Future<void> close() {
    _likedNoteSubscription?.cancel();

    return super.close();
  }

  void _handleStreams() {
    _likedNoteSubscription = likedNoteStream.listen((event) {
      emit(
        state.copyWith(
          likedNote: Note.fromEvent(event),
        ),
      );
    });
  }
}
