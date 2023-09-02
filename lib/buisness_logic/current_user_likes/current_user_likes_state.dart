part of 'current_user_likes_cubit.dart';

/// {@template current_state_likes_state}
/// The state of [CurrentUserLikesCubit].
/// {@endtemplate}
class CurrentUserLikesState extends Equatable {
  /// The current user like events.
  final List<NostrEvent> currentUserLikedPosts;

  /// Weither to show the loading indicator.
  final bool shouldShowLoadingIndicator;

  /// {@macro current_state_likes_state}
  const CurrentUserLikesState({
    this.currentUserLikedPosts = const [],
    this.shouldShowLoadingIndicator = true,
  });

  @override
  List<Object?> get props => [
        currentUserLikedPosts,
        shouldShowLoadingIndicator,
      ];

  /// {@macro current_state_likes_state}
  CurrentUserLikesState copyWith({
    List<NostrEvent>? currentUserLikedPosts,
    bool? shouldShowLoadingIndicator,
  }) {
    return CurrentUserLikesState(
      currentUserLikedPosts:
          currentUserLikedPosts ?? this.currentUserLikedPosts,
      shouldShowLoadingIndicator:
          shouldShowLoadingIndicator ?? this.shouldShowLoadingIndicator,
    );
  }
}

/// {@macro current_state_likes_state}
class CurrentUserLikesInitial extends CurrentUserLikesState {}
