// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_feed_cubit.dart';

class GlobalFeedState extends Equatable {
  final List<NostrEvent> feedPosts;
  const GlobalFeedState({
    this.feedPosts = const [],
  });

  @override
  List<Object?> get props => [
        feedPosts,
      ];

  GlobalFeedState copyWith({
    List<NostrEvent>? feedPosts,
  }) {
    return GlobalFeedState(
      feedPosts: feedPosts ?? this.feedPosts,
    );
  }
}

class GlobalFeedInitial extends GlobalFeedState {}
