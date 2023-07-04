part of 'home_page_after_login_cubit.dart';

/// {@template home_page_after_login_state}
/// The state of [HomePageAfterLoginCubit].
/// {@endtemplate}
class HomePageAfterLoginState extends Equatable {
  /// Weither connection to relays are established successfully.
  final bool didConnectedToRelaysAndSubscribedToTopics;

  /// Weither is loading state.
  final bool isLoading;

  /// An error to be shown if it exists.
  final String? error;

  /// All users cached metadata.
  final Map<String, NostrEvent> allUsersMetadata;

  @override
  List<Object?> get props => [
        didConnectedToRelaysAndSubscribedToTopics,
        isLoading,
        error,
        allUsersMetadata,
      ];

  /// {@macro home_page_after_login_state}
  const HomePageAfterLoginState({
    this.didConnectedToRelaysAndSubscribedToTopics = false,
    this.isLoading = false,
    this.error,
    this.allUsersMetadata = const {},
  });

  /// {@macro home_page_after_login_state}
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

  /// {@macro home_page_after_login_state}
  factory HomePageAfterLoginState.initial() {
    return HomePageAfterLoginInitial();
  }
}

/// {@macro home_page_after_login_state}
class HomePageAfterLoginInitial extends HomePageAfterLoginState {
  const HomePageAfterLoginInitial();
}
