import 'package:bloc/bloc.dart';
import 'package:ditto/model/note.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_client/nostr_client.dart';

part 'note_card_state.dart';

class NoteCardCubit extends Cubit<NoteCardState> {
  Note note;
  Stream<NostrEvent> currentUserMetadataStream;

  NoteCardCubit({
    required this.note,
    required this.currentUserMetadataStream,
  }) : super(NoteCardInitial()) {
    _handleStreams();
  }

  void _handleStreams() {
    currentUserMetadataStream.listen((event) {
      emit(state.copyWith(noteOwnerMetadata: event));
    });
  }
}
