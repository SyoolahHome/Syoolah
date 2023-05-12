// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_feed_cubit.dart';

class GlobalFeedState extends Equatable {
  final List<NostrEvent> feedPosts;
  final List<NostrEvent> shownFeedPosts;
  final List<Note> searchedFeedNotesPosts;
  final List<SearchOption> searchOptions;
  final DateTimeRange? dateRange;
  final bool shouldShowScrollToTopButton;

  @override
  List<Object?> get props => [
        feedPosts,
        searchOptions,
        dateRange,
        searchedFeedNotesPosts,
        shouldShowScrollToTopButton,
        shownFeedPosts,
      ];

  const GlobalFeedState({
    this.feedPosts = const [],
    this.shownFeedPosts = const [],
    this.searchedFeedNotesPosts = const [],
    this.searchOptions = const [],
    this.dateRange,
    this.shouldShowScrollToTopButton = false,
  });

  GlobalFeedState copyWith({
    List<NostrEvent>? feedPosts,
    List<NostrEvent>? shownFeedPosts,
    List<Note>? searchedFeedNotesPosts,
    List<SearchOption>? searchOptions,
    DateTimeRange? dateRange,
    bool? shouldShowScrollToTopButton,
  }) {
    return GlobalFeedState(
      feedPosts: feedPosts ?? this.feedPosts,
      searchedFeedNotesPosts:
          searchedFeedNotesPosts ?? this.searchedFeedNotesPosts,
      searchOptions: searchOptions ?? this.searchOptions,
      dateRange: dateRange ?? this.dateRange,
      shouldShowScrollToTopButton:
          shouldShowScrollToTopButton ?? this.shouldShowScrollToTopButton,
      shownFeedPosts: shownFeedPosts ?? this.shownFeedPosts,
    );
  }
}

class GlobalFeedInitial extends GlobalFeedState {
  const GlobalFeedInitial({
    required super.searchOptions,
  });
}
