part of 'current_user_posts_cubit.dart';

class CurrentUserPostsState extends Equatable {
  final List<NostrEvent> currentUserPosts;

  const CurrentUserPostsState({
    this.currentUserPosts = const [],
  });

  @override
  List<Object> get props => [currentUserPosts];

  CurrentUserPostsState copyWith({
    List<NostrEvent>? currentUserPosts,
  }) {
    return CurrentUserPostsState(
      currentUserPosts: currentUserPosts ?? this.currentUserPosts,
    );
  }
}

class CurrentUserPostsInitial extends CurrentUserPostsState {}
