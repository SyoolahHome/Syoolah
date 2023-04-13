// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_card_cubit.dart';

class NoteCardState extends Equatable {
  final NostrEvent? noteOwnerMetadata;
  final List<NostrEvent> noteLikes;
  final List<NostrEvent> noteComments;
  final bool localLiked;
  final String? error;
  final String? success;

  const NoteCardState({
    this.noteOwnerMetadata,
    this.noteLikes = const [],
    this.noteComments = const [],
    this.localLiked = false,
    this.error,
    this.success,
  });

  @override
  List<Object?> get props => [
        noteOwnerMetadata,
        noteLikes,
        localLiked,
        noteComments,
        error,
        success,
      ];

  NoteCardState copyWith({
    NostrEvent? noteOwnerMetadata,
    List<NostrEvent>? noteLikes,
    bool? localLiked,
    List<NostrEvent>? noteComments,
    String? error,
    String? success,
  }) {
    return NoteCardState(
      noteOwnerMetadata: noteOwnerMetadata ?? this.noteOwnerMetadata,
      noteLikes: noteLikes ?? this.noteLikes,
      localLiked: localLiked ?? this.localLiked,
      noteComments: noteComments ?? this.noteComments,
      error: error,
      success: success,
    );
  }
}

class NoteCardInitial extends NoteCardState {}
