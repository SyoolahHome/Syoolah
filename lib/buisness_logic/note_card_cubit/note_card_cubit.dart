import 'package:bloc/bloc.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_client/nostr_client.dart';

part 'note_card_state.dart';

class NoteCardCubit extends Cubit<NoteCardState> {
  Note note;
  Stream<NostrEvent> currentUserMetadataStream;
  Stream<NostrEvent> noteLikesStream;
  // Stream<NostrEvent> noteCommentsStream;

  NoteCardCubit({
    required this.note,
    required this.currentUserMetadataStream,
    required this.noteLikesStream,
    // required this.noteCommentsStream,
  }) : super(NoteCardInitial()) {
    _handleStreams();
  }

  void _handleStreams() {
    currentUserMetadataStream.listen((event) {
      emit(state.copyWith(noteOwnerMetadata: event));
    });

    noteLikesStream.listen((event) {
      emit(state.copyWith(noteLikes: [...state.noteLikes, event]));
    });
  }

  void likeNote() {
    NostrService.instance.likePost(note.event.id);
    emit(state.copyWith(localLiked: true));
  }

  bool isUserAlreadyLiked() {
    String pubKey =
        NostrKeyPairs(private: LocalDatabase.instance.getPrivateKey()!).public;

    final likers = state.noteLikes.map((e) => e.pubkey);
    final isUserLikers = likers.contains(pubKey);
    return isUserLikers;
  }
}
