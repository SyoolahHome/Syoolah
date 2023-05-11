import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

import '../../model/note.dart';

part 'liked_note_state.dart';

class LikedNoteCubit extends Cubit<LikedNoteState> {
  NostrEventsStream likedNoteStream;
  StreamSubscription<NostrEvent>? _likedNoteSubscription;

  LikedNoteCubit({
    required this.likedNoteStream,
  }) : super(LikedNoteInitial()) {
    _handleStreams();
  }

  @override
  Future<void> close() {
    likedNoteStream.close();
    _likedNoteSubscription?.cancel();

    return super.close();
  }

  void _handleStreams() {
    _likedNoteSubscription = likedNoteStream.stream.listen((event) {
      emit(
        state.copyWith(
          likedNote: Note.fromEvent(event),
        ),
      );
    });
  }
}
