import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'note_card_state.dart';

/// The responsible cubit about the note/post card.
/// {@endtemplate}
class NoteCardCubit extends Cubit<NoteCardState> {
  // The note associated with this instance of cubit.
  Note note;

  /// The Nostr Stream for the current user metadata.
  NostrEventsStream currentUserMetadataStream;

  /// The Nostr Stream for the note likes.
  NostrEventsStream noteLikesStream;

  /// The subscription for the [currentUserMetadataStream.stream].
  StreamSubscription<NostrEvent>? _currentUserMetadataSubscription;

  /// The subscription for the [noteLikesStream.stream].
  StreamSubscription<NostrEvent>? _noteLikesSubscription;

  /// {@macro note_card_cubit}
  NoteCardCubit({
    required this.note,
    required this.currentUserMetadataStream,
    required this.noteLikesStream,
  }) : super(NoteCardState.initial()) {
    _init();
  }

  void _init() {
    _handleStreams();
  }

  @override
  Future<void> close() {
    currentUserMetadataStream.close();
    noteLikesStream.close();
    _currentUserMetadataSubscription?.cancel();
    _noteLikesSubscription?.cancel();

    return super.close();
  }

  /// Likes the note.
  void likeNote() {
    NostrService.instance.send.likePost(note.event.id);
    emitIfOpen(state.copyWith(localLiked: true));
  }

  /// Weither the current user already liked the note or not.
  bool isUserAlreadyLiked() {
    final currentUserPrivateKey = LocalDatabase.instance.getPrivateKey();
    if (currentUserPrivateKey == null) {
      return false;
    }
    String pubKey = NostrKeyPairs(private: currentUserPrivateKey).public;
    final likers = state.noteLikes.map((e) => e.pubkey);

    return likers.contains(pubKey);
  }

  /// Copy the note id to the clipboard.
  Future<void> copyNoteId() async {
    await AppUtils.instance.copy(
      note.event.id,
      onSuccess: () => emitIfOpen(state.copyWith(success: "copySuccess".tr())),
      onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
      onEnd: () => emitIfOpen(state.copyWith()),
    );
  }

  /// Copy the note image links to the clipboard.
  Future<void> copyImagesLinks() async {
    if (note.imageLinks.isNotEmpty) {
      await AppUtils.instance.copy(
        note.imageLinks.join('\n'),
        onSuccess: () =>
            emitIfOpen(state.copyWith(success: "copySuccess".tr())),
        onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
        onEnd: () => emitIfOpen(state.copyWith()),
      );
    } else {
      emitIfOpen(state.copyWith(error: "noImagesToCopy".tr()));
      emitIfOpen(state.copyWith());
    }
  }

  /// Copy the note event to the clipboard.
  Future<void> copyNoteEvent() async {
    await AppUtils.instance.copy(
      note.event.serialized(),
      onSuccess: () => emitIfOpen(state.copyWith(success: "copySuccess".tr())),
      onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
      onEnd: () => emitIfOpen(state.copyWith()),
    );
  }

  /// Copy the note owner pubkey to the clipboard.
  Future<void> copyNoteOwnerPubKey() async {
    await AppUtils.instance.copy(
      note.event.pubkey,
      onSuccess: () => emitIfOpen(state.copyWith(success: "copySuccess".tr())),
      onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
      onEnd: () => emitIfOpen(state.copyWith()),
    );
  }

  /// Copy the note text content to the clipboard.
  Future<void> copyNoteContent() async {
    await AppUtils.instance.copy(
      note.noteOnly,
      onSuccess: () => emitIfOpen(state.copyWith(success: "copySuccess".tr())),
      onError: () => emitIfOpen(state.copyWith(error: "copyError".tr())),
      onEnd: () => emitIfOpen(state.copyWith()),
    );
  }

  /// emits a new state conditionally when the cubit is not closed.
  void emitIfOpen(NoteCardState copyWith) {
    if (!isClosed) {
      emit(copyWith);
    }
  }

  /// Reposts the note.
  void repostNote() {
    NostrService.instance.send.sendRepostEventFromCurrentUser(note);
    emit(state.copyWith(success: "repostSuccess".tr(), markAsReposted: true));
    emit(state.copyWith());
  }

  void _handleStreams() {
    _currentUserMetadataSubscription =
        currentUserMetadataStream.stream.listen((event) {
      if (!isClosed) {
        emitIfOpen(state.copyWith(noteOwnerMetadata: event));
      }
    });

    _noteLikesSubscription = noteLikesStream.stream.listen((event) {
      emitIfOpen(state.copyWith(noteLikes: [...state.noteLikes, event]));
    });
  }
}
