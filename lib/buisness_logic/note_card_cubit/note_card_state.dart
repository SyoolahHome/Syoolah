part of 'note_card_cubit.dart';

/// {@template note_card_state}
/// The state of [NoteCardCubit].
/// {@endtemplate}
class NoteCardState extends Equatable {
  /// The metadata of the note owner.
  final ReceivedNostrEvent? noteOwnerMetadata;

  /// The like events of the note.
  final List<ReceivedNostrEvent> noteLikes;

  /// The comment events of the note.
  final List<ReceivedNostrEvent> noteComments;

  /// A local variable to simulat ethe user action when the like icon button is pressed.
  final bool localLiked;

  /// An error message to be shown if it exists.
  final String? error;

  /// A success message to be shown if it exists.
  final String? success;

  /// A local variable to simulate the user action when the repost icon button is pressed.
  final bool markAsReposted;

  @override
  List<Object?> get props => [
        noteOwnerMetadata,
        noteLikes,
        localLiked,
        noteComments,
        error,
        success,
        markAsReposted,
      ];

  /// {@macro note_card_state}
  const NoteCardState({
    this.noteOwnerMetadata,
    this.noteLikes = const [],
    this.noteComments = const [],
    this.localLiked = false,
    this.error,
    this.success,
    this.markAsReposted = false,
  });

  /// Copies the current state with some new values.
  NoteCardState copyWith({
    ReceivedNostrEvent? noteOwnerMetadata,
    List<ReceivedNostrEvent>? noteLikes,
    bool? localLiked,
    List<ReceivedNostrEvent>? noteComments,
    String? error,
    String? success,
    bool? markAsReposted,
  }) {
    return NoteCardState(
      noteOwnerMetadata: noteOwnerMetadata ?? this.noteOwnerMetadata,
      noteLikes: noteLikes ?? this.noteLikes,
      noteComments: noteComments ?? this.noteComments,
      localLiked: localLiked ?? this.localLiked,
      error: error,
      success: success,
      markAsReposted: markAsReposted ?? this.markAsReposted,
    );
  }

  factory NoteCardState.initial() {
    return const NoteCardState();
  }
}

/// {@macro note_card_state}
class NoteCardInitial extends NoteCardState {}
