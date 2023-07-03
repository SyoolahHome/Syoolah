part of 'feed_box_cubit.dart';

/// {@template feed_box_state}
/// The state of [FeedBoxCubit]
/// {@endtemplate}
class FeedBoxState extends Equatable {
  /// Weither a feed box is highlighted
  final bool isHighlighted;

  @override
  List<Object> get props => [
        isHighlighted,
      ];

  /// {@macro feed_box_state}
  const FeedBoxState({
    this.isHighlighted = false,
  });

  factory FeedBoxState.initial() {
    return FeedBoxInitial();
  }
}

/// {@macro feed_box_state}
class FeedBoxInitial extends FeedBoxState {}
