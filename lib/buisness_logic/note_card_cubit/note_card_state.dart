part of 'note_card_cubit.dart';

class NoteCardState extends Equatable {
  final NostrEvent? noteOwnerMetadata;
  final List<NostrEvent> noteLikes;
  final List<NostrEvent> noteComments;
  final bool localLiked;
  final String? error;
  final String? success;
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

  const NoteCardState({
    this.noteOwnerMetadata,
    this.noteLikes = const [],
    this.noteComments = const [],
    this.localLiked = false,
    this.error,
    this.success,
    this.markAsReposted = false,
  });

  NoteCardState copyWith({
    NostrEvent? noteOwnerMetadata,
    List<NostrEvent>? noteLikes,
    bool? localLiked,
    List<NostrEvent>? noteComments,
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
}

class NoteCardInitial extends NoteCardState {}
