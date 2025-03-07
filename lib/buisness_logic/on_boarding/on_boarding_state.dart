part of 'on_boarding_cubit.dart';

/// {@template on_boarding_state}
/// The state of [OnBoardingCubit].
/// {@endtemplate}
class OnBoardingState extends Equatable {
  /// Weither or not the search button should be shown.
  final bool shouldShowSearchButton;

  /// The searched user.
  final Map<String, List<NostrEvent>> searchedUserEvents;

  final String searchQuery;

  /// An error if it exists.
  final String? error;

  /// Weither or not the user is searching for a another user via identifier or pubkey.
  ///
  final bool searchingForUser;

  @override
  List<Object?> get props => [
        shouldShowSearchButton,
        searchedUserEvents,
        error,
        searchingForUser,
      ];

  /// {@macro on_boarding_state}
  const OnBoardingState({
    this.shouldShowSearchButton = false,
    this.searchedUserEvents = const {},
    this.error,
    this.searchingForUser = false,
    this.searchQuery = "",
  });

  /// {@macro on_boarding_state}
  OnBoardingState copyWith({
    bool? shouldShowSearchButton,
    Map<String, List<NostrEvent>>? searchedUserEvents,
    String? error,
    bool? searchingForUser,
    String? searchQuery,
  }) {
    return OnBoardingState(
      searchQuery: searchQuery ?? this.searchQuery,
      shouldShowSearchButton:
          shouldShowSearchButton ?? this.shouldShowSearchButton,
      searchedUserEvents: searchedUserEvents ?? this.searchedUserEvents,
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
