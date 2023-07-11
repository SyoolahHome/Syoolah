part of 'comment_cubit.dart';

class CommentState extends Equatable {
  final UserMetaData? commentOwnerMetadata;
  const CommentState({
    this.commentOwnerMetadata,
  });

  @override
  List<Object> get props => [];

  CommentState copyWith({
    UserMetaData? commentOwnerMetadata,
  }) {
    return CommentState(
      commentOwnerMetadata: commentOwnerMetadata ?? this.commentOwnerMetadata,
    );
  }

  factory CommentState.initial() {
    return CommentInitial();
  }
}

class CommentInitial extends CommentState {}
