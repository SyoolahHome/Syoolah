part of 'global_feed_cubit.dart';

class GlobalFeedState extends Equatable {
  final List<NostrEvent> feedPosts;
  final List<NostrEvent> shownFeedPosts;
  final List<Note> searchedFeedNotesPosts;
  final List<SearchOption> searchOptions;
  final DateTimeRange? dateRange;

  @override
  List<Object?> get props => [
        feedPosts,
        searchOptions,
        dateRange,
        searchedFeedNotesPosts,
        shownFeedPosts,
      ];

  const GlobalFeedState({
    this.feedPosts = const [],
    this.shownFeedPosts = const [],
    this.searchedFeedNotesPosts = const [],
    this.searchOptions = const [],
    this.dateRange,
  });

  GlobalFeedState copyWith({
    List<NostrEvent>? feedPosts,
    List<NostrEvent>? shownFeedPosts,
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
}

class GlobalFeedInitial extends GlobalFeedState {
  const GlobalFeedInitial({
    required super.searchOptions,
  });
}
