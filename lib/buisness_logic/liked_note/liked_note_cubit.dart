import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/note.dart';
import 'package:equatable/equatable.dart';

part 'liked_note_state.dart';

/// {@template like_note_cubit}
/// The responsible cubit about the like note
/// {@endtemplate}
class LikedNoteCubit extends Cubit<LikedNoteState> {
  /// The Nostr stream for the like note.
  NostrEventsStream likedNoteStream;

  /// The subscription where we will listen to [likedNoteStream.stream].
  StreamSubscription<NostrEvent>? _likedNoteSubscription;

  /// {@macro like_note_cubit}
  LikedNoteCubit({
    required this.likedNoteStream,
  }) : super(LikedNoteState.initial()) {
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
      final likedNote = Note.fromEvent(event);

      emit(state.copyWith(likedNote: likedNote));
    });
  }
}
