part of 'global_cubit.dart';

/// {@macro global_state}
/// The state of [GlobalCubit].
/// {@endtemplate}
class GlobalState extends Equatable {
  /// The event holding followings.
  final ReceivedNostrEvent? currentUserFollowing;

  /// The event holding followers.
  final List<ReceivedNostrEvent> currentUserFollowers;

  /// Weither follow is perfermoed succesfully.
  final bool followedSuccessfully;

  @override
  List<Object?> get props => [
        currentUserFollowing,
        currentUserFollowers,
        followedSuccessfully,
      ];

  /// {@macro global_state}
  const GlobalState({
    this.currentUserFollowers = const [],
    this.currentUserFollowing,
    this.followedSuccessfully = false,
  });

  /// {@macro global_state}
  GlobalState copyWith({
    ReceivedNostrEvent? currentUserFollowing,
    List<ReceivedNostrEvent>? currentUserFollowers,
    bool? followedSuccessfully,
  }) {
    return GlobalState(
      followedSuccessfully: followedSuccessfully ?? this.followedSuccessfully,
      currentUserFollowers: currentUserFollowers ?? this.currentUserFollowers,
      currentUserFollowing: currentUserFollowing ?? this.currentUserFollowing,
    );
  }

  /// {@macro global_state}
  factory GlobalState.initial() {
    return GlobalInitial();
  }
}

/// {@macro global_state}
class GlobalInitial extends GlobalState {}
