// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_after_login_cubit.dart';

class HomePageAfterLoginState extends Equatable {
  final bool didConnectedToRelaysAndSubscribedToTopics;
  final bool isLoading;
  final String? error;
  final List<NostrEvent> feedPosts;

  const HomePageAfterLoginState({
    this.didConnectedToRelaysAndSubscribedToTopics = false,
    this.isLoading = false,
    this.error,
    this.feedPosts = const [],
  });

  @override
  List<Object?> get props => [
        didConnectedToRelaysAndSubscribedToTopics,
        isLoading,
        error,
        feedPosts,
      ];

  HomePageAfterLoginState copyWith({
    bool? didConnectedToRelaysAndSubscribedToTopics,
    bool? isLoading,
    String? error,
    List<NostrEvent>? feedPosts,
  }) {
    return HomePageAfterLoginState(
      didConnectedToRelaysAndSubscribedToTopics:
          didConnectedToRelaysAndSubscribedToTopics ??
              this.didConnectedToRelaysAndSubscribedToTopics,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      feedPosts: feedPosts ?? this.feedPosts,
    );
  }
}

class HomePageAfterLoginInitial extends HomePageAfterLoginState {
  const HomePageAfterLoginInitial();
}
