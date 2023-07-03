part of 'global_cubit.dart';

/// {@macro global_state}
/// The state of [GlobalCubit].
/// {@endtemplate}
class GlobalState extends Equatable {
  /// The event holding followings.
  final NostrEvent? currentUserFollowing;

  /// The event holding followers.
  final NostrEvent? currentUserFollowers;

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
    this.currentUserFollowers,
    this.currentUserFollowing,
    this.followedSuccessfully = false,
  });

  /// {@macro global_state}
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

  /// {@macro global_state}
  factory GlobalState.initial() {
    return GlobalInitial();
  }
}

/// {@macro global_state}
class GlobalInitial extends GlobalState {}
