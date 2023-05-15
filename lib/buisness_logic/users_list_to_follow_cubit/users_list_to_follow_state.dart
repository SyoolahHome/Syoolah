part of 'users_list_to_follow_cubit.dart';

class UsersListToFollowState extends Equatable {
  final NostrEvent? currentUserFollowing;
  final NostrEvent? currentUserFollowers;
  final List<NostrEvent> pubKeysMetadata;
  final bool followedSuccessfully;
  @override
  List<Object?> get props => [
        pubKeysMetadata,
        currentUserFollowing,
        currentUserFollowers,
        followedSuccessfully,
      ];

  const UsersListToFollowState({
    this.currentUserFollowing,
    this.currentUserFollowers,
    this.pubKeysMetadata = const [],
    this.followedSuccessfully = false,
  });

  UsersListToFollowState copyWith({
    List<NostrEvent>? pubKeysMetadata,
    NostrEvent? currentUserFollowing,
    NostrEvent? currentUserFollowers,
    bool? followedSuccessfully,
  }) {
    return UsersListToFollowState(
      currentUserFollowing: currentUserFollowing ?? this.currentUserFollowing,
      currentUserFollowers: currentUserFollowers ?? this.currentUserFollowers,
      pubKeysMetadata: pubKeysMetadata ?? this.pubKeysMetadata,
      followedSuccessfully: followedSuccessfully ?? this.followedSuccessfully,
    );
  }
}

class UsersListToFollowInitial extends UsersListToFollowState {}
