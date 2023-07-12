part of 'on_boarding_cubit.dart';

/// {@template on_boarding_state}
/// The state of [OnBoardingCubit].
/// {@endtemplate}
class OnBoardingState extends Equatable {
  /// Weither or not the search button should be shown.
  final bool shouldShowSearchButton;

  /// The searched user.
  final NostrEvent? searchedUserEvent;

  /// An error if it exists.
  final String? error;

  /// Weither or not the user is searching for a another user via identifier or pubkey.
  ///
  final bool searchingForUser;

  @override
  List<Object?> get props => [
        shouldShowSearchButton,
        searchedUserEvent,
        error,
        searchingForUser,
      ];

  /// {@macro on_boarding_state}
  const OnBoardingState({
    this.shouldShowSearchButton = false,
    this.searchedUserEvent,
    this.error,
    this.searchingForUser = false,
  });

  /// {@macro on_boarding_state}
  OnBoardingState copyWith({
    bool? shouldShowSearchButton,
    NostrEvent? searchedUserEvent,
    String? error,
    bool? searchingForUser,
  }) {
    return OnBoardingState(
      shouldShowSearchButton:
          shouldShowSearchButton ?? this.shouldShowSearchButton,
      searchedUserEvent: searchedUserEvent,
      error: error,
      searchingForUser: error != null && this.searchingForUser
          ? false
          : (searchingForUser ?? this.searchingForUser),
    );
  }

  /// {@macro on_boarding_state}s
  factory OnBoardingState.initial() {
    return OnBoardingInitial();
  }
}

/// {@macro on_boarding_state}
class OnBoardingInitial extends OnBoardingState {}
