part of 'current_user_likes_cubit.dart';

class CurrentUserLikesState extends Equatable {
  final List<NostrEvent> currentUserLikedPosts;

  const CurrentUserLikesState({this.currentUserLikedPosts = const []});

  @override
  List<Object> get props => [
        currentUserLikedPosts,
      ];

  CurrentUserLikesState copyWith({
    List<NostrEvent>? currentUserLikedPosts,
  }) {
    return CurrentUserLikesState(
      currentUserLikedPosts:
          currentUserLikedPosts ?? this.currentUserLikedPosts,
    );
  }
}

class CurrentUserLikesInitial extends CurrentUserLikesState {}
