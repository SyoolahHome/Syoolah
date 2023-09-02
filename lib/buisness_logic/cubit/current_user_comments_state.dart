part of 'current_user_comments_cubit.dart';

class CurrentUserCommentsState extends Equatable {
  final List<NostrEvent> currentUserComments;
  final bool shouldShowLoadingIndicator;
  const CurrentUserCommentsState({
    required this.currentUserComments,
    this.shouldShowLoadingIndicator = true,
  });

  @override
  List<Object> get props => [
        currentUserComments,
        shouldShowLoadingIndicator,
      ];

  CurrentUserCommentsState copyWith({
    List<NostrEvent>? currentUserComments,
    bool? shouldShowLoadingIndicator,
  }) {
    return CurrentUserCommentsState(
      currentUserComments: currentUserComments ?? this.currentUserComments,
      shouldShowLoadingIndicator:
          shouldShowLoadingIndicator ?? this.shouldShowLoadingIndicator,
    );
  }
}

class CurrentUserCommentsInitial extends CurrentUserCommentsState {
  CurrentUserCommentsInitial({
    super.currentUserComments = const [],
  });
}
