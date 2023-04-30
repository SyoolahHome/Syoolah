// ignore_for_file: , sort_constructors_first
part of 'home_page_after_login_cubit.dart';

class HomePageAfterLoginState extends Equatable {
  final bool didConnectedToRelaysAndSubscribedToTopics;
  final bool isLoading;
  final String? error;
  final Map<String, NostrEvent> allUsersMetadata;

  @override
  List<Object?> get props => [
        didConnectedToRelaysAndSubscribedToTopics,
        isLoading,
        error,
        allUsersMetadata,
      ];

  const HomePageAfterLoginState({
    this.didConnectedToRelaysAndSubscribedToTopics = false,
    this.isLoading = false,
    this.error,
    this.allUsersMetadata = const {},
  });

  HomePageAfterLoginState copyWith({
    bool? didConnectedToRelaysAndSubscribedToTopics,
    bool? isLoading,
    String? error,
    Map<String, NostrEvent>? allUsersMetadata,
  }) {
    return HomePageAfterLoginState(
      didConnectedToRelaysAndSubscribedToTopics:
          didConnectedToRelaysAndSubscribedToTopics ??
              this.didConnectedToRelaysAndSubscribedToTopics,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      allUsersMetadata: allUsersMetadata ?? this.allUsersMetadata,
    );
  }
}

class HomePageAfterLoginInitial extends HomePageAfterLoginState {
  const HomePageAfterLoginInitial();
}
