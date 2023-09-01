part of 'global_feed_cubit.dart';

/// {@template global_feed_state}
/// The state of the [GlobalFeedCubit].
/// {@endtemplate}
class GlobalFeedState extends Equatable {
  /// The list of feed posts.
  final List<ReceivedNostrEvent> feedPosts;

  /// The list of feed posts that are actually shown.
  final List<ReceivedNostrEvent> shownFeedPosts;

  /// The list of feed posts that are actually searched/filtered for.
  final List<Note> searchedFeedNotesPosts;

  /// The search options that will be shown in the advanced bottom sheet.
  final List<SearchOption> searchOptions;

  /// The search date range value.
  final DateTimeRange? dateRange;

  @override
  List<Object?> get props => [
        feedPosts,
        searchOptions,
        dateRange,
        searchedFeedNotesPosts,
        shownFeedPosts,
      ];

  /// {@macro global_feed_state}
  const GlobalFeedState({
    this.feedPosts = const [],
    this.shownFeedPosts = const [],
    this.searchedFeedNotesPosts = const [],
    this.searchOptions = const [],
    this.dateRange,
  });

  /// {@macro global_feed_state}
  GlobalFeedState copyWith({
    List<ReceivedNostrEvent>? feedPosts,
    List<ReceivedNostrEvent>? shownFeedPosts,
    List<Note>? searchedFeedNotesPosts,
    List<SearchOption>? searchOptions,
    DateTimeRange? dateRange,
  }) {
    return GlobalFeedState(
      feedPosts: feedPosts ?? this.feedPosts,
      searchedFeedNotesPosts:
          searchedFeedNotesPosts ?? this.searchedFeedNotesPosts,
      searchOptions: searchOptions ?? this.searchOptions,
      dateRange: dateRange ?? this.dateRange,
      shownFeedPosts: shownFeedPosts ?? this.shownFeedPosts,
    );
  }

  factory GlobalFeedState.initial({
    required List<SearchOption> searchOptions,
  }) {
    return GlobalFeedInitial(
      searchOptions: searchOptions,
    );
  }
}

/// {@macro global_feed_state}
class GlobalFeedInitial extends GlobalFeedState {
  const GlobalFeedInitial({
    required super.searchOptions,
  });
}
