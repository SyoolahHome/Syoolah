part of 'user_follows_cubit.dart';

class UserFollowsState extends Equatable {
  final NostrEvent? userFollowingEvent;
  final NostrEvent? userFollowersEvent;

  const UserFollowsState({
    this.userFollowersEvent,
    this.userFollowingEvent,
  });

  @override
  List<Object?> get props => [
        userFollowersEvent,
        userFollowingEvent,
      ];

  factory UserFollowsState.initial() {
    return UserFollowsInitial();
  }

  UserFollowsState copyWith({
    NostrEvent? userFollowersEvent,
    NostrEvent? userFollowingEvent,
  }) {
    return UserFollowsState(
      userFollowersEvent: userFollowersEvent ?? this.userFollowersEvent,
      userFollowingEvent: userFollowingEvent ?? this.userFollowingEvent,
    );
  }
}

class UserFollowsInitial extends UserFollowsState {
  UserFollowsInitial({
    super.userFollowersEvent,
    super.userFollowingEvent,
  });
}
