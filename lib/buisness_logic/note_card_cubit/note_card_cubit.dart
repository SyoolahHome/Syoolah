import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../services/utils/app_utils.dart';

part 'note_card_state.dart';

class NoteCardCubit extends Cubit<NoteCardState> {
  Note note;
  Stream<NostrEvent> currentUserMetadataStream;
  Stream<NostrEvent> noteLikesStream;

  StreamSubscription<NostrEvent>? _currentUserMetadataSubscription;
  StreamSubscription<NostrEvent>? _noteLikesSubscription;

  NoteCardCubit({
    required this.note,
    required this.currentUserMetadataStream,
    required this.noteLikesStream,
  }) : super(NoteCardInitial()) {
    _handleStreams();
  }

  void likeNote() {
    NostrService.instance.likePost(note.event.id);
    emitIfOpen(state.copyWith(localLiked: true));
  }

  bool isUserAlreadyLiked() {
    final currentUserPrivateKey = LocalDatabase.instance.getPrivateKey();
    if (currentUserPrivateKey == null) {
      return false;
    }
    String pubKey = NostrKeyPairs(private: currentUserPrivateKey).public;
    final likers = state.noteLikes.map((e) => e.pubkey);

    return likers.contains(pubKey);
  }

  void copyNoteId() async {
    await AppUtils.copy(
      note.event.id,
      onSuccess: () => emitIfOpen(state.copyWith(success: "copySuccess".tr())),
      onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
      onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
    );
  }

  void copyImagesLinks() async {
    if (note.imageLinks.isNotEmpty) {
      await AppUtils.copy(
        note.imageLinks.join('\n'),
        onSuccess: () =>
            emitIfOpen(state.copyWith(success: "copySuccess".tr())),
        onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
        onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
      );
    } else {
      emitIfOpen(state.copyWith(error: "noImagesToCopy".tr()));
      emitIfOpen(state.copyWith(error: null));
    }
  }

  void copyNoteEvent() async {
    await AppUtils.copy(
      note.event.serialized(),
      onSuccess: () => emitIfOpen(state.copyWith(success: "copySuccess".tr())),
      onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
      onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
    );
  }

  void copyNoteOwnerPubKey() async {
    await AppUtils.copy(
      note.event.pubkey,
      onSuccess: () => emitIfOpen(state.copyWith(success: "copySuccess".tr())),
      onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
      onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
    );
  }

  void copyNoteContent() async {
    await AppUtils.copy(
      note.noteOnly,
      onSuccess: () => emitIfOpen(state.copyWith(success: "copySuccess".tr())),
      onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
      onEnd: () => emitIfOpen(state.copyWith(success: null, error: null)),
    );
  }

  void emitIfOpen(NoteCardState copyWith) {
    if (!isClosed) {
      emit(copyWith);
    }
  }

  @override
  Future<void> close() {
    _currentUserMetadataSubscription?.cancel();
    _noteLikesSubscription?.cancel();

    return super.close();
  }

  void _handleStreams() {
    _currentUserMetadataSubscription =
        currentUserMetadataStream.listen((event) {
      if (!isClosed) {
        emitIfOpen(state.copyWith(noteOwnerMetadata: event));
      }
    });
    _noteLikesSubscription = noteLikesStream.listen((event) {
      emitIfOpen(state.copyWith(noteLikes: [...state.noteLikes, event]));
    });
  }
}
