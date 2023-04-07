// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_card_cubit.dart';

class NoteCardState extends Equatable {
  final NostrEvent? noteOwnerMetadata;
  final List<NostrEvent> noteLikes;
  final bool localLiked;
  
  const NoteCardState({
    this.noteOwnerMetadata,
    this.noteLikes = const [],
    this.localLiked = false,
  });

  @override
  List<Object?> get props => [
        noteOwnerMetadata,
        noteLikes,
        localLiked,
      ];

  NoteCardState copyWith({
    NostrEvent? noteOwnerMetadata,
    List<NostrEvent>? noteLikes,
    bool? localLiked,
  }) {
    return NoteCardState(
      noteOwnerMetadata: noteOwnerMetadata ?? this.noteOwnerMetadata,
      noteLikes: noteLikes ?? this.noteLikes,
      localLiked: localLiked ?? this.localLiked,
    );
  }
}

class NoteCardInitial extends NoteCardState {}
