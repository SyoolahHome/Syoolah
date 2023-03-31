// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_after_login_cubit.dart';

class HomePageAfterLoginState extends Equatable {
  final bool didConnectedToRelaysAndSubscribedToTopics;
  final bool isLoading;
  final String? error;

  const HomePageAfterLoginState({
    this.didConnectedToRelaysAndSubscribedToTopics = false,
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [
        didConnectedToRelaysAndSubscribedToTopics,
        isLoading,
        error,
      ];

  HomePageAfterLoginState copyWith({
    bool? didConnectedToRelaysAndSubscribedToTopics,
    bool? isLoading,
    String? error,
  }) {
    return HomePageAfterLoginState(
      didConnectedToRelaysAndSubscribedToTopics:
          didConnectedToRelaysAndSubscribedToTopics ??
              this.didConnectedToRelaysAndSubscribedToTopics,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HomePageAfterLoginInitial extends HomePageAfterLoginState {
  const HomePageAfterLoginInitial();
}
