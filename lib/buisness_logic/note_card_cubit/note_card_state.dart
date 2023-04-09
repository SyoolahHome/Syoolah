// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_card_cubit.dart';

class NoteCardState extends Equatable {
  final NostrEvent? noteOwnerMetadata;
  final List<NostrEvent> noteLikes;
  final List<NostrEvent> noteComments;
  final bool localLiked;

  const NoteCardState({
    this.noteOwnerMetadata,
    this.noteLikes = const [],
    this.noteComments = const [],
    this.localLiked = false,
  });

  @override
  List<Object?> get props => [
        noteOwnerMetadata,
        noteLikes,
        localLiked,
        noteComments,
      ];

  NoteCardState copyWith({
    NostrEvent? noteOwnerMetadata,
    List<NostrEvent>? noteLikes,
    bool? localLiked,
    List<NostrEvent>? noteComments,
  }) {
    return NoteCardState(
      noteOwnerMetadata: noteOwnerMetadata ?? this.noteOwnerMetadata,
      noteLikes: noteLikes ?? this.noteLikes,
      localLiked: localLiked ?? this.localLiked,
      noteComments: noteComments ?? this.noteComments,
    );
  }
}

class NoteCardInitial extends NoteCardState {}
