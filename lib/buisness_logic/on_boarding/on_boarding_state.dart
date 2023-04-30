// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final bool shouldShowSearchButton;
  final NostrEvent? searchedUser;
  final String? error;

  @override
  List<Object?> get props => [
        shouldShowSearchButton,
        searchedUser,
        error,
      ];

  const OnBoardingState({
    this.shouldShowSearchButton = false,
    this.searchedUser,
    this.error,
  });

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
}

class OnBoardingInitial extends OnBoardingState {}
