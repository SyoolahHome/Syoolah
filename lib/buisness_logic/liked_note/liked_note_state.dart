part of 'liked_note_cubit.dart';

class LikedNoteState extends Equatable {
  final Note? likedNote;
  @override
  List<Object?> get props => [
        likedNote,
      ];

  const LikedNoteState({
    this.likedNote,
  });

  LikedNoteState copyWith({
    Note? likedNote,
  }) {
    return LikedNoteState(
      likedNote: likedNote ?? this.likedNote,
    );
  }
}

class LikedNoteInitial extends LikedNoteState {}
