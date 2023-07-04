part of 'users_list_to_follow_cubit.dart';

/// {@template users_list_to_follow_state}
/// THe state of [UsersListToFollowCubit].
/// {@endtemplate}
class UsersListToFollowState extends Equatable {
  /// The current user following list event.
  final NostrEvent? currentUserFollowing;

  ///The current user followers event.
  final NostrEvent? currentUserFollowers;

  /// A list of users metadata with the given metadata.
  final List<NostrEvent> pubKeysMetadata;

  /// Weither the follow method ran succesfully.
  final bool followedSuccessfully;
  @override
  List<Object?> get props => [
        pubKeysMetadata,
        currentUserFollowing,
        currentUserFollowers,
        followedSuccessfully,
      ];

  /// {@macro users_list_to_follow_state}
  const UsersListToFollowState({
    this.currentUserFollowing,
    this.currentUserFollowers,
    this.pubKeysMetadata = const [],
    this.followedSuccessfully = false,
  });

  /// {@macro users_list_to_follow_state}
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

  /// {@macro users_list_to_follow_state}
  factory UsersListToFollowState.initial() {
    return UsersListToFollowInitial();
  }
}

/// {@macro users_list_to_follow_state}
class UsersListToFollowInitial extends UsersListToFollowState {}
