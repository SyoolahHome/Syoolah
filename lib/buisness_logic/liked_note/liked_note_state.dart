// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'liked_note_cubit.dart';

class LikedNoteState extends Equatable {
  final Note? likedNote;
  const LikedNoteState({
    this.likedNote,
  });

  @override
  List<Object?> get props => [
        likedNote,
      ];

  LikedNoteState copyWith({
    Note? likedNote,
  }) {
    return LikedNoteState(
      likedNote: likedNote ?? this.likedNote,
    );
  }
}

class LikedNoteInitial extends LikedNoteState {}
