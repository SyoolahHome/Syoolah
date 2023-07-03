part of 'current_user_reposts_cubit.dart';

/// {@template current_user_reposts_state}
/// The state of [CurrentUserRepostsCubit].
/// {endtemplate}
class CurrentUserRepostsState extends Equatable {
  final List<NostrEvent> currentUserReposts;

  /// {@macro current_user_reposts_state}
  const CurrentUserRepostsState({
    this.currentUserReposts = const [],
  });

  @override
  List<Object> get props => [currentUserReposts];

  /// {@macro current_user_reposts_state}
  CurrentUserRepostsState copyWith({
    List<NostrEvent>? currentUserReposts,
  }) {
    return CurrentUserRepostsState(
      currentUserReposts: currentUserReposts ?? this.currentUserReposts,
    );
  }

  /// {@macro current_user_reposts_state}
  factory CurrentUserRepostsState.initial() {
    return CurrentUserRepostsInitial();
  }
}

/// {@macro current_user_reposts_state}
class CurrentUserRepostsInitial extends CurrentUserRepostsState {}
