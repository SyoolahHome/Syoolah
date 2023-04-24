// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final bool shouldShowSearchButton;
  final NostrEvent? searchedUser;
  final String? error;
  const OnBoardingState({
    this.shouldShowSearchButton = false,
    this.searchedUser,
    this.error,
  });

  @override
  List<Object?> get props => [
        shouldShowSearchButton,
        searchedUser,
        error,
      ];

  OnBoardingState copyWith({
    bool? shouldShowSearchButton,
    NostrEvent? searchedUser,
    String? error,
  }) {
    return OnBoardingState(
      searchedUser: searchedUser,
      shouldShowSearchButton:
          shouldShowSearchButton ?? this.shouldShowSearchButton,
      error: error,
    );
  }
}

class OnBoardingInitial extends OnBoardingState {}
