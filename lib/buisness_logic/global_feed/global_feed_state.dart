// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_feed_cubit.dart';

class GlobalFeedState extends Equatable {
  final List<NostrEvent> feedPosts;
  final List<Note> searchedFeedNotesPosts;
  final List<SearchOption> searchOptions;
  final DateTimeRange? dateRange;
  const GlobalFeedState({
    this.feedPosts = const [],
    this.searchedFeedNotesPosts = const [],
    this.searchOptions = const [],
    this.dateRange,
  });

  @override
  List<Object?> get props => [
        feedPosts,
        searchOptions,
        dateRange,
        searchedFeedNotesPosts,
      ];

  GlobalFeedState copyWith({
    List<NostrEvent>? feedPosts,
    List<Note>? searchedFeedNotesPosts,
    List<SearchOption>? searchOptions,
    DateTimeRange? dateRange,
  }) {
    return GlobalFeedState(
      dateRange: dateRange ?? this.dateRange,
      feedPosts: feedPosts ?? this.feedPosts,
      searchOptions: searchOptions ?? this.searchOptions,
      searchedFeedNotesPosts:
          searchedFeedNotesPosts ?? this.searchedFeedNotesPosts,
    );
  }
}

class GlobalFeedInitial extends GlobalFeedState {
  const GlobalFeedInitial({
    required super.searchOptions,
  });
}
