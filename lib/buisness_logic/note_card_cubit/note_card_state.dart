// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_card_cubit.dart';

class NoteCardState extends Equatable {
  final NostrEvent? noteOwnerMetadata;
  const NoteCardState({
    this.noteOwnerMetadata,
  });

  @override
  List<Object?> get props => [
        noteOwnerMetadata,
      ];

  NoteCardState copyWith({
    NostrEvent? noteOwnerMetadata,
  }) {
    return NoteCardState(
      noteOwnerMetadata: noteOwnerMetadata ?? this.noteOwnerMetadata,
    );
  }
}

class NoteCardInitial extends NoteCardState {}
