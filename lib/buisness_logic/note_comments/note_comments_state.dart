// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_comments_cubit.dart';

class NoteCommentsState extends Equatable {
  final List<NostrEvent> noteComments;

  const NoteCommentsState({
    this.noteComments = const [],
  });

  @override
  List<Object> get props => [
        noteComments,
      ];

  NoteCommentsState copyWith({
    List<NostrEvent>? noteComments,
  }) {
    return NoteCommentsState(
      noteComments: noteComments ?? this.noteComments,
    );
  }
}

class NoteCommentsInitial extends NoteCommentsState {}
