part of 'users_list_to_follow_cubit.dart';

class UsersListToFollowState extends Equatable {
  final NostrEvent? currentUserFollowing;
  final NostrEvent? currentUserFollowers;
  final List<NostrEvent> pubKeysMetadata;

  @override
  List<Object?> get props => [
        pubKeysMetadata,
        currentUserFollowing,
        currentUserFollowers,
      ];

  const UsersListToFollowState({
    this.currentUserFollowing,
    this.currentUserFollowers,
    this.pubKeysMetadata = const [],
  });

  UsersListToFollowState copyWith({
    List<NostrEvent>? pubKeysMetadata,
    NostrEvent? currentUserFollowing,
    NostrEvent? currentUserFollowers,
  }) {
    return UsersListToFollowState(
      currentUserFollowing: currentUserFollowing ?? this.currentUserFollowing,
      currentUserFollowers: currentUserFollowers ?? this.currentUserFollowers,
      pubKeysMetadata: pubKeysMetadata ?? this.pubKeysMetadata,
    );
  }
}

class UsersListToFollowInitial extends UsersListToFollowState {}
