part of 'current_user_posts_cubit.dart';

/// {@template current_user_posts_state}
/// The state of [CurrentUserPostsCubit].
/// {@endtemplate}
class CurrentUserPostsState extends Equatable {
  final List<NostrEvent> currentUserPosts;

  /// {@macro current_user_posts_state}
  const CurrentUserPostsState({
    this.currentUserPosts = const [],
  });

  @override
  List<Object> get props => [
        currentUserPosts,
      ];

  /// {@macro current_user_posts_state}
  CurrentUserPostsState copyWith({
    List<NostrEvent>? currentUserPosts,
  }) {
    return CurrentUserPostsState(
      currentUserPosts: currentUserPosts ?? this.currentUserPosts,
    );
  }

  /// {@macro current_user_posts_state}
  factory CurrentUserPostsState.initial() {
    return CurrentUserPostsInitial();
  }
}

class CurrentUserPostsInitial extends CurrentUserPostsState {}
