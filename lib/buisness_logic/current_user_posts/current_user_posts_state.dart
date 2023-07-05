part of 'current_user_posts_cubit.dart';

/// {@template current_user_posts_state}
/// The state of [CurrentUserPostsCubit].
/// {@endtemplate}
class CurrentUserPostsState extends Equatable {
  final List<NostrEvent> currentUserPosts;
  final bool shouldShowLoadingIndicator;

  /// {@macro current_user_posts_state}
  const CurrentUserPostsState({
    this.currentUserPosts = const [],
    this.shouldShowLoadingIndicator = true,
  });

  @override
  List<Object> get props => [
        currentUserPosts,
        shouldShowLoadingIndicator,
      ];

  /// {@macro current_user_posts_state}
  CurrentUserPostsState copyWith({
    List<NostrEvent>? currentUserPosts,
    bool? shouldShowLoadingIndicator,
  }) {
    return CurrentUserPostsState(
      currentUserPosts: currentUserPosts ?? this.currentUserPosts,
      shouldShowLoadingIndicator:
          shouldShowLoadingIndicator ?? this.shouldShowLoadingIndicator,
    );
  }

  /// {@macro current_user_posts_state}
  factory CurrentUserPostsState.initial() {
    return CurrentUserPostsInitial();
  }
}

class CurrentUserPostsInitial extends CurrentUserPostsState {}
