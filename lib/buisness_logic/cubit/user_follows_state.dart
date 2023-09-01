part of 'user_follows_cubit.dart';

class UserFollowsState extends Equatable {
  final ReceivedNostrEvent? userFollowingEvent;
  final List<ReceivedNostrEvent> userFollowersEvents;

  const UserFollowsState({
    this.userFollowersEvents = const [],
    this.userFollowingEvent,
  });

  @override
  List<Object?> get props => [
        userFollowersEvents,
        userFollowingEvent,
      ];

  factory UserFollowsState.initial() {
    return UserFollowsInitial();
  }

  UserFollowsState copyWith({
    ReceivedNostrEvent? userFollowingEvent,
    List<ReceivedNostrEvent>? userFollowersEvents,
  }) {
    return UserFollowsState(
      userFollowersEvents: userFollowersEvents ?? this.userFollowersEvents,
      userFollowingEvent: userFollowingEvent ?? this.userFollowingEvent,
    );
  }
}

class UserFollowsInitial extends UserFollowsState {
  UserFollowsInitial({
    super.userFollowersEvents,
    super.userFollowingEvent,
  });
}
