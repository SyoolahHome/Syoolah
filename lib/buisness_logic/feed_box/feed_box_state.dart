part of 'feed_box_cubit.dart';

class FeedBoxState extends Equatable {
  final bool isHighlighted;

  @override
  List<Object> get props => [
        isHighlighted,
      ];

  const FeedBoxState({
    this.isHighlighted = false,
  });
}

class FeedBoxInitial extends FeedBoxState {}
