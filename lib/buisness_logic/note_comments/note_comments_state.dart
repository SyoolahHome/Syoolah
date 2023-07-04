part of 'note_comments_cubit.dart';

/// {@template note_comments_state}
/// The state of [NoteCommentsCubit].
/// {@endtemplate}
class NoteCommentsState extends Equatable {
  /// The list of comments of the note.
  final List<NostrEvent> noteComments;

  @override
  List<Object> get props => [noteComments];

  /// {@macro note_comments_state}
  const NoteCommentsState({
    this.noteComments = const [],
  });

  /// {@macro note_comments_state}
  NoteCommentsState copyWith({
    List<NostrEvent>? noteComments,
  }) {
    return NoteCommentsState(noteComments: noteComments ?? this.noteComments);
  }

  /// {@macro note_comments_state}
  factory NoteCommentsState.initial() {
    return NoteCommentsInitial();
  }
}

/// {@macro note_comments_state}
class NoteCommentsInitial extends NoteCommentsState {}
