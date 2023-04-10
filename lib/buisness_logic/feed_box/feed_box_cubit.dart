import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feed_box_state.dart';

class FeedBoxCubit extends Cubit<FeedBoxState> {
  FeedBoxCubit() : super(FeedBoxInitial());

  void highlightBox() {
    emit(const FeedBoxState(isHighlighted: true));
  }

  void unHighlightBox() {
    emit(const FeedBoxState(isHighlighted: false));
  }
}
