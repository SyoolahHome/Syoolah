part of 'on_boarding_cubit.dart';

/// {@template on_boarding_state}
/// The state of [OnBoardingCubit].
/// {@endtemplate}
class OnBoardingState extends Equatable {
  /// Weither or not the search button should be shown.
  final bool shouldShowSearchButton;

  /// The searched user.
  final NostrEvent? searchedUser;

  /// An error if it exists.
  final String? error;

  @override
  List<Object?> get props => [shouldShowSearchButton, searchedUser, error];

  /// {@macro on_boarding_state}
  const OnBoardingState({
    this.shouldShowSearchButton = false,
    this.searchedUser,
    this.error,
  });

  /// {@macro on_boarding_state}
  OnBoardingState copyWith({
    bool? shouldShowSearchButton,
    NostrEvent? searchedUser,
    String? error,
  }) {
    return OnBoardingState(
      shouldShowSearchButton:
          shouldShowSearchButton ?? this.shouldShowSearchButton,
      searchedUser: searchedUser,
      error: error,
    );
  }

  /// {@macro on_boarding_state}s
  factory OnBoardingState.initial() {
    return const OnBoardingState();
  }
}

/// {@macro on_boarding_state}
class OnBoardingInitial extends OnBoardingState {}
