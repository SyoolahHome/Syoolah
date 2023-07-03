part of 'current_user_likes_cubit.dart';

/// {@template current_state_likes_state}
/// The state of [CurrentUserLikesCubit].
/// {@endtemplate}
class CurrentUserLikesState extends Equatable {
  final List<NostrEvent> currentUserLikedPosts;

  /// {@macro current_state_likes_state}
  const CurrentUserLikesState({
    this.currentUserLikedPosts = const [],
  });

  @override
  List<Object> get props => [
        currentUserLikedPosts,
      ];

  /// {@macro current_state_likes_state}
  CurrentUserLikesState copyWith({
    List<NostrEvent>? currentUserLikedPosts,
  }) {
    return CurrentUserLikesState(
      currentUserLikedPosts:
          currentUserLikedPosts ?? this.currentUserLikedPosts,
    );
  }
}

/// {@macro current_state_likes_state}
class CurrentUserLikesInitial extends CurrentUserLikesState {}
