import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

import '../../model/note.dart';

part 'liked_note_state.dart';

class LikedNoteCubit extends Cubit<LikedNoteState> {
  Stream<NostrEvent> likedNoteStream;
  LikedNoteCubit({
    required this.likedNoteStream,
  }) : super(LikedNoteInitial()) {
    _handleStreams();
  }

  void _handleStreams() {
    likedNoteStream.listen((event) {
      emit(
        state.copyWith(
          likedNote: Note.fromEvent(event),
        ),
      );
    });
  }
}
