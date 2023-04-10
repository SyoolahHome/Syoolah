part of 'feed_box_cubit.dart';

class FeedBoxState extends Equatable {
  final bool isHighlighted;

  const FeedBoxState({
    this.isHighlighted = false,
  });

  @override
  List<Object> get props => [
        isHighlighted,
      ];
}

class FeedBoxInitial extends FeedBoxState {}
