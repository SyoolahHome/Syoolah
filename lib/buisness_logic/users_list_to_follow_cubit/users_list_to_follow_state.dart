part of 'users_list_to_follow_cubit.dart';

class UsersListToFollowState extends Equatable {
  final NostrEvent? currentUserFollowing;
  final NostrEvent? currentUserFollowers;
  final List<NostrEvent> pubKeysMetadata;

  const UsersListToFollowState({
    this.currentUserFollowing,
    this.currentUserFollowers,
    this.pubKeysMetadata = const [],
  });

  @override
  List<Object?> get props => [
        pubKeysMetadata,
        currentUserFollowing,
        currentUserFollowers,
      ];

  UsersListToFollowState copyWith({
    List<NostrEvent>? pubKeysMetadata,
    NostrEvent? currentUserFollowing,
    NostrEvent? currentUserFollowers,
  }) {
    return UsersListToFollowState(
      pubKeysMetadata: pubKeysMetadata ?? this.pubKeysMetadata,
      currentUserFollowers: currentUserFollowers ?? this.currentUserFollowers,
      currentUserFollowing: currentUserFollowing ?? this.currentUserFollowing,
    );
  }
}

class UsersListToFollowInitial extends UsersListToFollowState {}
