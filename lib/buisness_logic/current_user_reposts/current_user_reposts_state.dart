part of 'current_user_reposts_cubit.dart';

/// {@template current_user_reposts_state}
/// The state of [CurrentUserRepostsCubit].
/// {endtemplate}
class CurrentUserRepostsState extends Equatable {
  final List<ReceivedNostrEvent> currentUserReposts;

  final bool shouldShowLoadingIndicator;

  /// {@macro current_user_reposts_state}
  const CurrentUserRepostsState({
    this.currentUserReposts = const [],
    this.shouldShowLoadingIndicator = true,
  });

  @override
  List<Object> get props => [currentUserReposts, shouldShowLoadingIndicator];

  /// {@macro current_user_reposts_state}
  CurrentUserRepostsState copyWith({
    List<ReceivedNostrEvent>? currentUserReposts,
    bool? shouldShowLoadingIndicator,
  }) {
    return CurrentUserRepostsState(
      currentUserReposts: currentUserReposts ?? this.currentUserReposts,
      shouldShowLoadingIndicator:
          shouldShowLoadingIndicator ?? this.shouldShowLoadingIndicator,
    );
  }

  /// {@macro current_user_reposts_state}
  factory CurrentUserRepostsState.initial() {
    return CurrentUserRepostsInitial();
  }
}

/// {@macro current_user_reposts_state}
class CurrentUserRepostsInitial extends CurrentUserRepostsState {}
