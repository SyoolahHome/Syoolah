part of 'global_cubit.dart';

class GlobalState extends Equatable {
  final NostrEvent? currentUserFollowing;
  final NostrEvent? currentUserFollowers;
  final bool followedSuccessfully;
  @override
  List<Object?> get props => [
        currentUserFollowing,
        currentUserFollowers,
        followedSuccessfully,
      ];

  const GlobalState({
    this.currentUserFollowers,
    this.currentUserFollowing,
    this.followedSuccessfully = false,
  });

  GlobalState copyWith({
    NostrEvent? currentUserFollowing,
    NostrEvent? currentUserFollowers,
    bool? followedSuccessfully,
  }) {
    return GlobalState(
      followedSuccessfully: followedSuccessfully ?? this.followedSuccessfully,
      currentUserFollowers: currentUserFollowers ?? this.currentUserFollowers,
      currentUserFollowing: currentUserFollowing ?? this.currentUserFollowing,
    );
  }
}

class GlobalInitial extends GlobalState {}
