// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final bool shouldShowSearchButton;
  final NostrEvent? searchedUser;

  const OnBoardingState({
    this.shouldShowSearchButton = false,
    this.searchedUser,
  });

  @override
  List<Object?> get props => [
        shouldShowSearchButton,
        searchedUser,
      ];

  OnBoardingState copyWith({
    bool? shouldShowSearchButton,
    NostrEvent? searchedUser,
  }) {
    return OnBoardingState(
      searchedUser: searchedUser,
      shouldShowSearchButton:
          shouldShowSearchButton ?? this.shouldShowSearchButton,
    );
  }
}

class OnBoardingInitial extends OnBoardingState {}
