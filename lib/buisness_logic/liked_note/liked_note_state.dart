part of 'liked_note_cubit.dart';

/// {@template liked_note_state}
/// The state of [LikedNoteCubit].
/// {@endtemplate}
class LikedNoteState extends Equatable {
  /// The note itself.
  final Note? likedNote;
  @override
  List<Object?> get props => [likedNote];

  /// {@macro liked_note_state}
  const LikedNoteState({
    this.likedNote,
  });

  /// {@macro liked_note_state}
  LikedNoteState copyWith({
    Note? likedNote,
  }) {
    return LikedNoteState(
      likedNote: likedNote ?? this.likedNote,
    );
  }

  /// {@macro liked_note_state}
  factory LikedNoteState.initial() {
    return LikedNoteState();
  }
}

/// {@macro liked_note_state}
class LikedNoteInitial extends LikedNoteState {}
