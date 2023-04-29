import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/strings.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';

import '../../services/utils/utils.dart';

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
      if (!isClosed) {
        emitIfOpen(state.copyWith(noteOwnerMetadata: event));
      }
    });

    noteLikesStream.listen((event) {
      emitIfOpen(state.copyWith(noteLikes: [...state.noteLikes, event]));
    });
  }

  void likeNote() {
    NostrService.instance.likePost(note.event.id);
    emitIfOpen(state.copyWith(localLiked: true));
  }

  bool isUserAlreadyLiked() {
    String pubKey =
        NostrKeyPairs(private: LocalDatabase.instance.getPrivateKey()!).public;

    final likers = state.noteLikes.map((e) => e.pubkey);
    final isUserLikers = likers.contains(pubKey);
    return isUserLikers;
  }

  void copyNoteId() async {
    await AppUtils.copy(
      note.event.id,
      onSuccess: () =>
          emitIfOpen(state.copyWith(success: AppStrings.copySuccess)),
      onError: () => emitIfOpen(state.copyWith(error: AppStrings.copyError)),
      onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
    );
  }

  void copyImagesLinks() async {
    if (note.imageLinks.isNotEmpty) {
      await AppUtils.copy(
        note.imageLinks.join('\n'),
        onSuccess: () =>
            emitIfOpen(state.copyWith(success: AppStrings.copySuccess)),
        onError: () => emitIfOpen(state.copyWith(error: AppStrings.copyError)),
        onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
      );
    } else {
      emitIfOpen(state.copyWith(error: AppStrings.noImagesToCopy));
      emitIfOpen(state.copyWith(error: null));
    }
  }

  void copyNoteEvent() async {
    await AppUtils.copy(
      note.event.serialized(),
      onSuccess: () =>
          emitIfOpen(state.copyWith(success: AppStrings.copySuccess)),
      onError: () => emitIfOpen(state.copyWith(error: AppStrings.copyError)),
      onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
    );
  }

  void copyNoteOwnerPubKey() async {
    await AppUtils.copy(
      note.event.pubkey,
      onSuccess: () =>
          emitIfOpen(state.copyWith(success: AppStrings.copySuccess)),
      onError: () => emitIfOpen(state.copyWith(error: AppStrings.copyError)),
      onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
    );
  }

  void copyNoteContent() async {
    await AppUtils.copy(
      note.noteOnly,
      onSuccess: () =>
          emitIfOpen(state.copyWith(success: AppStrings.copySuccess)),
      onError: () => emitIfOpen(state.copyWith(error: AppStrings.copyError)),
      onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
    );
  }

  void emitIfOpen(NoteCardState copyWith) {
    if (!isClosed) {
      emit(copyWith);
    }
  }
}
